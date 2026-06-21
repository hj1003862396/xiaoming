# 移除撰写计划中的单元测试要求 实施计划

> **对于代理工作者：** 必须使用子技能：使用 xiaoming:xiaoming-brainstorming-subagent-driven-development（推荐）或 xiaoming:xiaoming-brainstorming-executing-plans 逐任务实施此计划。步骤使用复选框（`- [ ]`）语法进行追踪。

**目标：** 从 `xiaoming-writing-plans/SKILL.md` 中完全移除 TDD 单元测试的强制要求，改为“编写代码 + 验证”模式。

**架构：** 通过精确修改 `skills/xiaoming-writing-plans/SKILL.md` 文件内容，将其中的 TDD 描述和模板更新为简单的两步代码编写与命令行验证流程，并通过自我审查确认无遗漏。

**技术栈：** Markdown

---

### Task 1：修改 `skills/xiaoming-writing-plans/SKILL.md` 中的 TDD 描述

**文件：**
- 修改：`skills/xiaoming-writing-plans/SKILL.md`

- [ ] **步骤 1：写最少实施代码**
  修改 `skills/xiaoming-writing-plans/SKILL.md` 中的“概述”、“细粒度任务粒度”、“注意事项”和“任务结构模板”，移除 TDD 以及单元测试四步法的强性要求，将其重构为两步循环（代码编写、命令行/脚本验证）。

- [ ] **步骤 2：运行命令验证其正确性**
  运行：`git diff skills/xiaoming-writing-plans/SKILL.md`
  预期：显示所有与“测试”、“TDD”相关的强制要求已全部被干净地移除，修改内容完全符合我们在规格文档中约定的方案。
