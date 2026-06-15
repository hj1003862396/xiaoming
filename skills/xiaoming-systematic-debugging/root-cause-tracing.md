# 根本原因追踪 (Root Cause Tracing)

## 概述

Bug 往往在调用栈的深处表现出来（git init 在错误目录，文件创建在错误位置，数据库用错误路径打开）。你的本能是在错误出现的地方修复，但那是在治标。

**核心原则：** 向后追踪调用链，直到找到原始触发点，然后在来源处修复。

## 使用时机

```dot
digraph when_to_use {
    "Bug 出现在栈的深处？" [shape=diamond];
    "能向后追踪？" [shape=diamond];
    "在症状点修复" [shape=box];
    "追踪到原始触发点" [shape=box];
    "更好：同时添加纵深防御" [shape=box];

    "Bug 出现在栈的深处？" -> "能向后追踪？" [label="是"];
    "能向后追踪？" -> "追踪到原始触发点" [label="是"];
    "能向后追踪？" -> "在症状点修复" [label="否 - 死胡同"];
    "追踪到原始触发点" -> "更好：同时添加纵深防御";
}
```

**适用情形：**
- 错误发生在执行的深处（而非入口点）
- 堆栈跟踪 (stack trace) 显示长调用链
- 不清楚无效数据从哪里产生
- 需要找出哪个测试/代码触发了问题

## 追踪流程

### 1. 观察症状
```
错误：git init 在 ~/project/packages/core 中失败
```

### 2. 找到直接原因
**什么代码直接导致了这个？**
```typescript
await execFileAsync('git', ['init'], { cwd: projectDir });
```

### 3. 问：什么调用了这个？
```typescript
WorktreeManager.createSessionWorktree(projectDir, sessionId)
  → 被 Session.initializeWorkspace() 调用
  → 被 Session.create() 调用
  → 被 Project.create() 处的测试调用
```

### 4. 继续向上追踪
**传入了什么值？**
- `projectDir = ''`（空字符串！）
- 空字符串作为 `cwd` 解析为 `process.cwd()`
- 那就是源代码目录！

### 5. 找到原始触发点
**空字符串从哪里来？**
```typescript
const context = setupCoreTest(); // 返回 { tempDir: '' }
Project.create('name', context.tempDir); // 在 beforeEach 之前访问了！
```

## 添加堆栈跟踪

当你无法手动追踪时，添加埋点：

```typescript
// 在有问题的操作之前
async function gitInit(directory: string) {
  const stack = new Error().stack;
  console.error('DEBUG git init:', {
    directory,
    cwd: process.cwd(),
    nodeEnv: process.env.NODE_ENV,
    stack,
  });

  await execFileAsync('git', ['init'], { cwd: directory });
}
```

**重要：** 在测试中使用 `console.error()`（而非 logger——可能不会显示）

**运行并捕获：**
```bash
npm test 2>&1 | grep 'DEBUG git init'
```

**分析堆栈跟踪：**
- 寻找测试文件名
- 找到触发调用的行号
- 识别模式（同一个测试？同一个参数？）

## 找出哪个测试导致了污染

如果某个东西在测试期间出现，但你不知道是哪个测试：

使用此目录中的二分搜索脚本 `find-polluter.sh`：

```bash
./find-polluter.sh '.git' 'src/**/*.test.ts'
```

逐一运行测试，在第一个污染者处停止。见脚本了解使用方法。

## 真实示例：空 projectDir

**症状：** `.git` 在 `packages/core/`（源代码）中创建

**追踪链：**
1. `git init` 在 `process.cwd()` 中运行 ← 空 cwd 参数
2. WorktreeManager 用空 projectDir 调用
3. Session.create() 传入了空字符串
4. 测试在 beforeEach 之前访问了 `context.tempDir`
5. setupCoreTest() 最初返回 `{ tempDir: '' }`

**根本原因：** 顶级变量初始化访问了空值

**修复：** 将 tempDir 改为 getter，如果在 beforeEach 之前访问则抛出异常

**同时添加了纵深防御：**
- 第 1 层：Project.create() 验证目录
- 第 2 层：WorkspaceManager 验证非空
- 第 3 层：NODE_ENV 保护，拒绝在 tmpdir 外执行 git init
- 第 4 层：git init 前的堆栈跟踪 (stack trace) 日志

## 关键原则

```dot
digraph principle {
    "找到直接原因" [shape=ellipse];
    "能向上追踪一层？" [shape=diamond];
    "向后追踪" [shape=box];
    "这是来源吗？" [shape=diamond];
    "在来源处修复" [shape=box];
    "在每一层添加验证" [shape=box];
    "Bug 不可能发生" [shape=doublecircle];
    "永远不要只修复症状" [shape=octagon, style=filled, fillcolor=red, fontcolor=white];

    "找到直接原因" -> "能向上追踪一层？";
    "能向上追踪一层？" -> "向后追踪" [label="是"];
    "能向上追踪一层？" -> "永远不要只修复症状" [label="否"];
    "向后追踪" -> "这是来源吗？";
    "这是来源吗？" -> "向后追踪" [label="否 - 继续"];
    "这是来源吗？" -> "在来源处修复" [label="是"];
    "在来源处修复" -> "在每一层添加验证";
    "在每一层添加验证" -> "Bug 不可能发生";
}
```

**永远不要只修复错误出现的地方。** 向后追踪找到原始触发点。

## 堆栈跟踪技巧

**在测试中：** 使用 `console.error()` 而非 logger——logger 可能被抑制
**在操作之前：** 在危险操作之前记录，而非在失败之后
**包含上下文：** 目录、cwd、环境变量、时间戳
**捕获堆栈：** `new Error().stack` 显示完整调用链

## 真实影响

来自调试会话（2025-10-03）：
- 通过 5 层追踪找到根本原因
- 在来源处修复（getter 验证）
- 添加了 4 层防御
- 1847 个测试通过，零污染
