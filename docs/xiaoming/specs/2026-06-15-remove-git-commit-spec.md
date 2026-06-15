# 移除技能文档中 Git 提交规约的设计说明

## 目标
为了适应不依赖自动/强制 git commit 提交的开发流，从所有技能（SKILL.md）文件中移除强制的 git 提交步骤，改用名词性、保存性或同步性的描述。

## 变更方案
- 移除 `xiaoming-brainstorming` 中关于“提交 (commit)”的步骤和指令描述。
- 移除 `xiaoming-writing-plans` 中的“步骤 5：提交 (commit)”段落及其关联的指令引用，并调整列表描述。
- 移除 `xiaoming-using-git-worktrees` 中关于 `git commit` 提交 .gitignore 的描述。
- 移除 `xiaoming-verification-before-completion` 中包含的 `提交 (commit)` 事件前置约束。
- 移除 `xiaoming-writing-skills` 中部署时的 `提交 (commit) 到 git`。

## 验证计划
修改完成后，需要运行 `scripts/verify-xiaoming.sh` 脚本确保整体重命名与格式仍旧符合基本校验要求。并手动检查各 SKILL.md 文档的渲染效果和逻辑连贯性。
