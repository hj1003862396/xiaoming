---
name: xiaoming-requesting-code-review
description: "在完成任务、实现主要特性或在合并前使用，以验证工作是否符合要求"
---

# 请求代码审查 (Requesting Code Review)

派发一个代码审查子代理 (subagent)，在问题扩散之前捕获它们。审查者获得精确设计的上下文进行评估——永远不是你的会话历史。这让审查者专注于工作产物，而非你的思考过程，同时也保留了你自己的上下文用于后续工作。

**核心原则：** 尽早审查，频繁审查。

## 何时请求审查

**强制性：**
- 子代理驱动开发 (subagent-driven development) 中每个任务后
- 完成主要特性后
- 合并到 main 之前

**可选但有价值：**
- 卡住时（获得新视角）
- 重构之前（建立基准）
- 修复复杂 bug 后

## 如何请求

**1. 获取 git SHA：**
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # 或 origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

**2. 派发代码审查子代理：**

使用 `general-purpose` 类型的 Task 工具，填写 `code-reviewer.md` 的模板

**占位符：**
- `{DESCRIPTION}` — 你构建内容的简要摘要
- `{PLAN_OR_REQUIREMENTS}` — 它应该做什么
- `{BASE_SHA}` — 起始提交 (commit)
- `{HEAD_SHA}` — 结束提交 (commit)

**3. 根据反馈行动：**
- 立即修复**严重 (Critical)** 问题
- 在继续前修复**重要 (Important)** 问题
- 记录**次要 (Minor)** 问题留待后续
- 如果审查者有误，反驳（附上理由）

## 示例

```
[刚完成 Task 2：添加验证函数]

你：在继续之前让我请求代码审查。

BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

[派发代码审查子代理]
  DESCRIPTION: 添加了 verifyIndex() 和 repairIndex()，包含 4 种问题类型
  PLAN_OR_REQUIREMENTS: docs/xiaoming/plans/deployment-plan.md 中的 Task 2
  BASE_SHA: a7981ec
  HEAD_SHA: 3df7661

[子代理返回]：
  优点：架构清晰，测试真实
  问题：
    重要：缺少进度指示器
    次要：报告间隔的魔法数字 (100)
  评估：可以继续

你：[修复进度指示器]
[继续到 Task 3]
```

## 与工作流集成

**子代理驱动开发：**
- 每个任务后审查
- 在问题积累之前捕获
- 修复后再进入下一个任务

**执行计划：**
- 每个任务后或在自然检查点审查
- 获取反馈，应用，继续

**临时开发：**
- 合并前审查
- 卡住时审查

## 红线警告

**永远不要：**
- 因为"很简单"就跳过审查
- 忽略严重 (Critical) 问题
- 在未修复重要 (Important) 问题的情况下继续
- 与有效的技术反馈争论

**如果审查者有误：**
- 用技术理由反驳
- 展示证明其有效的代码/测试
- 请求澄清

模板见：`requesting-code-review/code-reviewer.md`
