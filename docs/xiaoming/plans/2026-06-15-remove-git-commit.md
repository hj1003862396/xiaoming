# 移除技能文档中 Git 提交规约 实施计划

> **对于代理工作者：** 必须使用子技能：使用 xiaoming:xiaoming-brainstorming-executing-plans 逐任务实施此计划。步骤使用复选框（`- [ ]`）语法进行追踪。

**目标：** 从核心技能文档中清除所有关于强制进行 git 提交 (commit) 的指引。

**架构：** 逐文件对五个核心技能文档进行就地内容替换。

**技术栈：** Markdown, Git

---

### Task 1: 修改 brainstorming 技能
**文件：**
- 修改：[SKILL.md](file:///Users/hanjie/IdeaProjects/xiaoming/skills/xiaoming-brainstorming/SKILL.md)

- [ ] **步骤 1：修改文档中的提交要求**
  用新版没有“提交”的描述替换第 29 行、第 114 行、第 129 行。
- [ ] **步骤 2：运行校验脚本确保合法**
  运行：`./scripts/verify-xiaoming.sh`
  预期：校验通过

### Task 2: 修改 writing-plans 技能
**文件：**
- 修改：[SKILL.md](file:///Users/hanjie/IdeaProjects/xiaoming/skills/xiaoming-writing-plans/SKILL.md)

- [ ] **步骤 1：移除频繁提交规约和步骤 5：提交**
  删除第 43 行关于“提交”的说明，删除第 98-103 行关于“步骤 5：提交 (commit)”的代码，并更新其余行。
- [ ] **步骤 2：运行校验脚本确保合法**
  运行：`./scripts/verify-xiaoming.sh`
  预期：校验通过

### Task 3: 修改 using-git-worktrees 技能
**文件：**
- 修改：[SKILL.md](file:///Users/hanjie/IdeaProjects/xiaoming/skills/xiaoming-using-git-worktrees/SKILL.md)

- [ ] **步骤 1：修改工作树中的提交文字**
  修改第 93 行和第 167 行，用“保存变更”替换“提交变更”。
- [ ] **步骤 2：运行校验脚本确保合法**
  运行：`./scripts/verify-xiaoming.sh`
  预期：校验通过

### Task 4: 修改 verification-before-completion 技能
**文件：**
- 修改：[SKILL.md](file:///Users/hanjie/IdeaProjects/xiaoming/skills/xiaoming-verification-before-completion/SKILL.md)

- [ ] **步骤 1：移除前置提交的触发条件**
  修改第 123 行，用“保存变更、创建 PR、完成任务”替换“提交 (commit)、创建 PR、完成任务”。
- [ ] **步骤 2：运行校验脚本确保合法**
  运行：`./scripts/verify-xiaoming.sh`
  预期：校验通过

### Task 5: 修改 writing-skills 技能
**文件：**
- 修改：[SKILL.md](file:///Users/hanjie/IdeaProjects/xiaoming/skills/xiaoming-writing-skills/SKILL.md)

- [ ] **步骤 1：移除部署时提交的文字**
  修改第 630 行。
- [ ] **步骤 2：运行校验脚本确保合法**
  运行：`./scripts/verify-xiaoming.sh`
  预期：校验通过
