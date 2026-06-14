---
name: finishing-a-development-branch
description: "当实施完成、所有测试通过，并且您需要决定如何集成工作时使用 - 通过提供合并、PR 或清理等结构化选项来指导完成开发工作"
---

# 完成开发分支 (Finishing a Development Branch)

## 概述

通过呈现清晰选项并处理所选工作流，引导完成开发工作。

**核心原则：** 验证测试 → 检测环境 → 呈现选项 → 执行所选 → 清理。

**开始时宣布：** "我正在使用 finishing-a-development-branch 技能 (skill) 来完成此工作。"

## 流程

### 步骤 1：验证测试

**在呈现选项之前，验证测试是否通过：**

```bash
# 运行项目的测试套件
npm test / cargo test / pytest / go test ./...
```

**如果测试失败：**
```
测试失败（<N> 个失败）。在完成之前必须修复：

[显示失败详情]

在测试通过之前无法进行合并/PR。
```

停止。不要继续到步骤 2。

**如果测试通过：** 继续到步骤 2。

### 步骤 2：检测环境

**在呈现选项之前，确定工作区状态：**

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
```

这决定了显示哪个菜单以及如何执行清理：

| 状态 | 菜单 | 清理 |
|-------|------|---------| 
| `GIT_DIR == GIT_COMMON`（普通仓库） | 标准 4 个选项 | 无工作树 (worktree) 需清理 |
| `GIT_DIR != GIT_COMMON`，命名分支 | 标准 4 个选项 | 基于来源（见步骤 6） |
| `GIT_DIR != GIT_COMMON`，分离 HEAD | 精简 3 个选项（无合并） | 不清理（外部管理） |

### 步骤 3：确定基础分支

```bash
# 尝试常见基础分支
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

或询问："这个分支是从 main 分出的——正确吗？"

### 步骤 4：呈现选项

**普通仓库和命名分支工作树 (worktree)——精确呈现以下 4 个选项：**

```
实施完成。你想怎么处理？

1. 本地合并回 <base-branch>
2. 推送并创建 Pull Request
3. 保留分支不变（我稍后处理）
4. 丢弃此工作

选择哪个？
```

**分离 HEAD——精确呈现以下 3 个选项：**

```
实施完成。你处于分离 HEAD 状态（外部管理的工作区）。

1. 推送为新分支并创建 Pull Request
2. 保留不变（我稍后处理）
3. 丢弃此工作

选择哪个？
```

**不要添加解释**——保持选项简洁。

### 步骤 5：执行所选

#### 选项 1：本地合并

```bash
# 获取主仓库根目录以确保 CWD 安全
MAIN_ROOT=$(git -C "$(git rev-parse --git-common-dir)/.." rev-parse --show-toplevel)
cd "$MAIN_ROOT"

# 先合并——在移除任何内容之前验证成功
git checkout <base-branch>
git pull
git merge <feature-branch>

# 在合并结果上验证测试
<test command>

# 仅在合并成功后：清理工作树 (worktree)（步骤 6），然后删除分支
```

然后：清理工作树 (worktree)（步骤 6），然后删除分支：

```bash
git branch -d <feature-branch>
```

#### 选项 2：推送并创建 PR

```bash
# 推送分支
git push -u origin <feature-branch>

# 创建 PR
gh pr create --title "<title>" --body "$(cat <<'EOF'
## 摘要
<2-3 条变更要点>

## 测试计划
- [ ] <验证步骤>
EOF
)"
```

**不要清理工作树 (worktree)**——用户需要它来处理 PR 反馈。

#### 选项 3：保留不变

汇报："保留分支 <name>。工作树 (worktree) 保留在 <path>。"

**不要清理工作树 (worktree)。**

#### 选项 4：丢弃

**先确认：**
```
这将永久删除：
- 分支 <name>
- 所有提交 (commit)：<commit-list>
- 工作树 (worktree) 位于 <path>

输入 'discard' 确认。
```

等待精确的确认输入。

确认后：
```bash
MAIN_ROOT=$(git -C "$(git rev-parse --git-common-dir)/.." rev-parse --show-toplevel)
cd "$MAIN_ROOT"
```

然后：清理工作树 (worktree)（步骤 6），然后强制删除分支：
```bash
git branch -D <feature-branch>
```

### 步骤 6：清理工作区

**仅在选项 1 和 4 时执行。** 选项 2 和 3 始终保留工作树 (worktree)。

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
WORKTREE_PATH=$(git rev-parse --show-toplevel)
```

**如果 `GIT_DIR == GIT_COMMON`：** 普通仓库，无工作树需清理。完成。

**如果工作树路径在 `.worktrees/`、`worktrees/` 或 `~/.config/xiaoming/worktrees/` 下：** 小明 (Xiaoming) 创建了此工作树——由我们负责清理。

```bash
MAIN_ROOT=$(git -C "$(git rev-parse --git-common-dir)/.." rev-parse --show-toplevel)
cd "$MAIN_ROOT"
git worktree remove "$WORKTREE_PATH"
git worktree prune  # 自愈：清理任何失效的注册
```

**否则：** 主机环境（运行框架）拥有此工作区。不得移除。如果你的平台提供了退出工作区的工具，使用它。否则，保留工作区原状。

## 快速参考

| 选项 | 合并 | 推送 | 保留工作树 | 清理分支 |
|--------|-------|------|---------------|----------------|
| 1. 本地合并 | 是 | - | - | 是 |
| 2. 创建 PR | - | 是 | 是 | - |
| 3. 保留不变 | - | - | 是 | - |
| 4. 丢弃 | - | - | - | 是（强制） |

## 常见错误

**跳过测试验证**
- **问题：** 合并了损坏的代码，创建了失败的 PR
- **修复：** 在提供选项之前始终验证测试

**开放式问题**
- **问题：** "接下来我该做什么？"含义模糊
- **修复：** 精确呈现 4 个结构化选项（分离 HEAD 时 3 个）

**在选项 2 时清理工作树**
- **问题：** 移除了用户需要用于 PR 迭代的工作树
- **修复：** 仅在选项 1 和 4 时清理

**在移除工作树之前删除分支**
- **问题：** `git branch -d` 失败，因为工作树仍在引用该分支
- **修复：** 先合并，移除工作树，然后删除分支

**从工作树内部运行 git worktree remove**
- **问题：** 当前目录在被移除的工作树内时，命令静默失败
- **修复：** 在执行 `git worktree remove` 之前始终 `cd` 到主仓库根目录

**清理运行框架拥有的工作树**
- **问题：** 移除运行框架创建的工作树会导致幽灵状态
- **修复：** 仅清理 `.worktrees/`、`worktrees/` 或 `~/.config/xiaoming/worktrees/` 下的工作树

**丢弃时无确认**
- **问题：** 意外删除工作
- **修复：** 要求键入 "discard" 进行确认

## 红线警告

**永远不要：**
- 在测试失败的情况下继续
- 不在合并结果上验证测试就合并
- 不经确认就删除工作
- 未经明确请求就强制推送
- 在确认合并成功之前移除工作树
- 清理你没有创建的工作树（来源检查）
- 从工作树内部运行 `git worktree remove`

**始终：**
- 在提供选项之前验证测试
- 在呈现菜单之前检测环境
- 精确呈现 4 个选项（分离 HEAD 时 3 个）
- 选项 4 需要键入确认
- 仅在选项 1 和 4 时清理工作树
- 在移除工作树之前 `cd` 到主仓库根目录
- 移除后运行 `git worktree prune`
