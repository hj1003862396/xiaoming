---
name: xiaoming-using-git-worktrees
description: "在启动需要与当前工作区隔离的特性工作时，或在执行实施计划之前使用 - 通过原生工具或 git worktree 回退方案确保隔离的工作区存在"
---

# 使用 Git 工作树 (Using Git Worktrees)

## 概述

确保工作在隔离的工作区中进行。优先使用平台的原生工作树工具。仅在没有原生工具时才回退到手动 git 工作树。

**核心原则：** 首先检测现有的隔离环境。然后使用原生工具。然后回退到 git。永远不要与运行框架 (harness) 对抗。

**开始时宣布：** "我正在使用 using-git-worktrees 技能 (skill) 来设置隔离的工作区。"

## 步骤 0：检测现有隔离

**在创建任何内容之前，检查你是否已经在隔离的工作区中。**

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
BRANCH=$(git branch --show-current)
```

**子模块保护：** `GIT_DIR != GIT_COMMON` 在 git 子模块内部也成立。在得出"已在工作树中"的结论之前，验证你不在子模块中：

```bash
# 如果返回路径，你在子模块中而非工作树中——按普通仓库处理
git rev-parse --show-superproject-working-tree 2>/dev/null
```

**如果 `GIT_DIR != GIT_COMMON`（且不在子模块中）：** 你已经在链接的工作树 (worktree) 中。跳至步骤 3（项目设置）。不要再创建另一个工作树。

汇报分支状态：
- 在某分支上："已在隔离工作区 `<path>`，分支 `<name>`。"
- 分离 HEAD："已在隔离工作区 `<path>`（分离 HEAD，外部管理）。完成时需要创建分支。"

**如果 `GIT_DIR == GIT_COMMON`（或在子模块中）：** 你在普通仓库检出中。

用户是否已在指令中说明其工作树偏好？如果没有，在创建工作树之前询问同意：

> "是否需要我设置一个隔离的工作树 (worktree)？它可以保护你当前的分支不受改动影响。"

在没有询问的情况下遵守任何已声明的偏好。如果用户拒绝同意，就地工作并跳至步骤 3。

## 步骤 1：创建隔离工作区

**你有两种机制。按此顺序尝试。**

### 1a. 原生工作树工具（优先）

用户已要求隔离工作区（步骤 0 同意）。你是否已有创建工作树的方法？可能是名为 `EnterWorktree`、`WorktreeCreate`、`/worktree` 命令或 `--worktree` 标志的工具。如果有，使用它并跳至步骤 3。

原生工具会自动处理目录放置、分支创建和清理。在有原生工具的情况下使用 `git worktree add` 会创建你的运行框架无法看到或管理的幽灵状态。

只有在你没有可用的原生工作树工具时才继续步骤 1b。

### 1b. Git 工作树回退

**只有当步骤 1a 不适用时才使用此方法**——你没有可用的原生工作树工具。使用 git 手动创建工作树。

#### 目录选择

按此优先顺序执行。用户的明确偏好始终优先于观察到的文件系统状态。

1. **检查指令中是否有已声明的工作树目录偏好。** 如果用户已指定，直接使用，无需询问。

2. **检查是否有现有的项目本地工作树目录：**
   ```bash
   ls -d .worktrees 2>/dev/null     # 优先（隐藏）
   ls -d worktrees 2>/dev/null      # 备选
   ```
   如果找到，使用它。如果两者都存在，`.worktrees` 优先。

3. **检查是否有现有的全局目录：**
   ```bash
   project=$(basename "$(git rev-parse --show-toplevel)")
   ls -d ~/.config/xiaoming/worktrees/$project 2>/dev/null
   ```
   如果找到，使用它（与旧版全局路径向后兼容）。

4. **如果没有其他指导**，默认使用项目根目录下的 `.worktrees/`。

#### 安全验证（仅项目本地目录）

**必须在创建工作树之前验证目录已被忽略：**

```bash
git check-ignore -q .worktrees 2>/dev/null || git check-ignore -q worktrees 2>/dev/null
```

**如果未被忽略：** 添加到 .gitignore，保存变更，然后继续。

**为什么重要：** 防止意外将工作树内容提交到仓库。

全局目录（`~/.config/xiaoming/worktrees/`）无需验证。

#### 创建工作树

```bash
project=$(basename "$(git rev-parse --show-toplevel)")

# 根据所选位置确定路径
# 项目本地：path="$LOCATION/$BRANCH_NAME"
# 全局：path="~/.config/xiaoming/worktrees/$project/$BRANCH_NAME"

git worktree add "$path" -b "$BRANCH_NAME"
cd "$path"
```

**沙箱回退：** 如果 `git worktree add` 因权限错误（沙箱拒绝）失败，告知用户沙箱阻止了工作树创建，你将在当前目录中工作。然后就地运行设置和基准测试。

## 步骤 3：项目设置

自动检测并运行适当的设置：

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

## 步骤 4：验证干净的基准

运行测试以确保工作区以干净状态开始：

```bash
# 使用适合项目的命令
npm test / cargo test / pytest / go test ./...
```

**如果测试失败：** 汇报失败，询问是否继续或排查。

**如果测试通过：** 汇报就绪。

### 汇报

```
工作树 (worktree) 已就绪，位于 <full-path>
测试通过（<N> 个测试，0 个失败）
准备好实施 <feature-name>
```

## 快速参考

| 情况 | 操作 |
|-----------|--------|
| 已在链接的工作树中 | 跳过创建（步骤 0） |
| 在子模块中 | 按普通仓库处理（步骤 0 保护） |
| 有原生工作树工具 | 使用它（步骤 1a） |
| 无原生工具 | Git 工作树回退（步骤 1b） |
| `.worktrees/` 存在 | 使用它（验证已忽略） |
| `worktrees/` 存在 | 使用它（验证已忽略） |
| 两者都存在 | 使用 `.worktrees/` |
| 两者都不存在 | 检查指令文件，然后默认 `.worktrees/` |
| 全局路径存在 | 使用它（向后兼容） |
| 目录未被忽略 | 添加到 .gitignore + 保存变更 |
| 创建时权限错误 | 沙箱回退，就地工作 |
| 基准时测试失败 | 汇报失败 + 询问 |
| 无 package.json/Cargo.toml | 跳过依赖安装 |

## 常见错误

### 与运行框架对抗

- **问题：** 在平台已提供隔离时使用 `git worktree add`
- **修复：** 步骤 0 检测现有隔离。步骤 1a 优先使用原生工具。

### 跳过检测

- **问题：** 在现有工作树内部创建嵌套工作树
- **修复：** 在创建任何内容之前始终运行步骤 0

### 跳过忽略验证

- **问题：** 工作树内容被追踪，污染 git 状态
- **修复：** 在创建项目本地工作树之前始终使用 `git check-ignore`

### 假设目录位置

- **问题：** 造成不一致，违反项目约定
- **修复：** 遵循优先顺序：现有 > 全局旧路径 > 指令文件 > 默认

### 在测试失败时继续

- **问题：** 无法区分新 bug 和已有问题
- **修复：** 汇报失败，获得继续的明确许可

## 红线警告

**永远不要：**
- 当步骤 0 检测到现有隔离时创建工作树
- 在有原生工作树工具时使用 `git worktree add`（例如 `EnterWorktree`）。这是最常见的错误——如果你有它，就用它。
- 跳过步骤 1a 直接使用步骤 1b 的 git 命令
- 创建工作树而不验证其已被忽略（项目本地）
- 跳过基准测试验证
- 在不询问的情况下在测试失败时继续

**始终：**
- 首先运行步骤 0 检测
- 优先使用原生工具，而非 git 回退
- 遵循目录优先顺序：现有 > 全局旧路径 > 指令文件 > 默认
- 验证项目本地目录已被忽略
- 自动检测并运行项目设置
- 验证干净的测试基准
