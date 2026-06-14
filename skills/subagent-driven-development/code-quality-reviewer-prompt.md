# 代码质量审查员提示模板

派发代码质量审查子代理 (subagent) 时使用此模板。

**目的：** 验证实施构建良好（整洁、有测试、可维护）

**仅在规格文档 (spec) 符合性审查通过后才派发。**

```
Task tool (general-purpose):
  使用 requesting-code-review/code-reviewer.md 的模板

  DESCRIPTION: [任务摘要，来自实施者的报告]
  PLAN_OR_REQUIREMENTS: Task N from [plan-file]
  BASE_SHA: [任务前的提交 (commit)]
  HEAD_SHA: [当前提交 (commit)]
```

**除了标准代码质量关注点外，审查员还应检查：**
- 每个文件是否有一个明确的职责和定义良好的接口？
- 各单元是否已分解，使其可以独立理解和测试？
- 实施是否遵循了计划中的文件结构？
- 此次实施是否创建了已经很大的新文件，或显著扩大了现有文件？（不要标记已存在的文件大小——专注于此次变更的贡献。）

**代码审查员返回：** 优点、问题（严重/重要/次要）、评估
