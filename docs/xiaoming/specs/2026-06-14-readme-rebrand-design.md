# 设计规约：汉化并重命名 README.md、CLAUDE.md 和 AGENTS.md 

本设计规约详述了将 **Xiaoming (小明)** 项目的 `README.md`、`CLAUDE.md` 和 `AGENTS.md` 文件进行汉化与品牌重命名（由 Superpowers 重命名为 小明/Xiaoming）的实施方案。

---

## 变更目标与修改范围

1. **README.md 全文汉化与品牌替换**：
   * 将标题改为 `# 小明 (Xiaoming)`。
   * 全文翻译为中文，确保语义流畅且专业。
   * 将所有的 `Superpowers` / `superpowers` 文本和命名空间（如 `superpowers\:`）替换为 `Xiaoming` / `xiaoming` 或 `xiaoming:`。
   * 更新安装指令中的仓库链接为用户本地仓库 `https://github.com/hj1003862396/xiaoming`。
   * 更新基本工作流及技能库中的技能名称，例如将 `using-superpowers` 替换为 `xiaoming-using-xiaoming`，将 `brainstorming` 替换为 `xiaoming`，并将其余所有的英文技能描述汉化。

2. **CLAUDE.md & AGENTS.md 全文汉化与品牌替换**：
   * 将标题改为 `# 小明 (Xiaoming) — 贡献者指南`。
   * 将所有面向 AI Agent 的硬性合规要求、PR 提交限制、新平台支持的验证流程进行深度汉化，使贡献规范更易于中文贡献者理解。
   * 更新文中的命令前缀、包名及链接（例如 `using-superpowers` $\rightarrow$ `xiaoming-using-xiaoming`，`superpowers\:writing-skills` $\rightarrow$ `xiaoming:xiaoming-brainstorming-writing-skills`）。

---

## 详细变更方案

### 1. `README.md` 变更方案

主要翻译并替换的内容对应如下：
* **项目定位描述**：
  * "Superpowers is a complete software development methodology..." $\rightarrow$ "小明 (Xiaoming) 是一套专为编码代理（Coding Agents）设计的完整软件开发方法论..."
* **各平台安装指令中包名更新**：
  * Claude Code: `/plugin install xiaoming@claude-plugins-official`
  * Droid: `droid plugin marketplace add https://github.com/hj1003862396/xiaoming` 且安装为 `xiaoming@xiaoming`
  * Gemini CLI: `gemini extensions install https://github.com/hj1003862396/xiaoming` 和 `gemini extensions update xiaoming`
  * Copilot CLI: `copilot plugin install xiaoming@xiaoming-marketplace`
* **工作流与技能映射**：
  1. `brainstorming` $\rightarrow$ `xiaoming` (功能说明翻译)
  2. `using-git-worktrees` $\rightarrow$ `using-git-worktrees` (功能说明翻译)
  3. `writing-plans` $\rightarrow$ `writing-plans` (功能说明翻译)
  4. `subagent-driven-development` / `executing-plans` (功能说明翻译)
  5. `test-driven-development` (功能说明翻译)
  6. `requesting-code-review` (功能说明翻译)
  7. `finishing-a-development-branch` (功能说明翻译)
* **Meta 技能说明**：
  * `using-superpowers` $\rightarrow$ `xiaoming-using-xiaoming` (引导说明汉化)

### 2. `CLAUDE.md` 与 `AGENTS.md` 变更方案

这两个文件在物理上完全相同，修改内容如下：
* **AI 代理贡献红线**：
  * 逐条翻译 AI 代理提 PR 前的自检（如：阅读 `PULL_REQUEST_TEMPLATE.md`、检查重复 PR、说明使用的模型及插件环境、获取真人伙伴对完整 diff 的显式确认等）。
* **提 PR 的要求**：
  * 强调必须提交到 `dev` 分支而非 `main`。
  - 声明不接受的变更：第三方依赖、无评估的技能更改、个人特定配置、批量乱提 PR、理论性修复。
* **新平台支持验证**：
  * 翻译验证测试方案：打开干净的会话输入 "Let's make a react todo list"，确保引导脚本能自动触发 `xiaoming`（原 `brainstorming`）技能。

---

## 验证与验收标准

1. **格式与链接验证**：
   * 确保生成的 `README.md`、`CLAUDE.md` 和 `AGENTS.md` 中所有 Markdown 链接、代码块格式正确。
   * 确认 `https://github.com/hj1003862396/xiaoming` 及 `https://github.com/hj1003862396/xiaoming/issues` 无拼写错误。
2. **校验无遗留关键字**：
   * 在项目中全局检索不分大小写的 `superpowers`。除了测试脚本和校验脚本中的特意检查外，这三个主文档中不应存在任何遗留的 `superpowers` 或 `Superpowers`。
