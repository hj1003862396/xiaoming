# README, CLAUDE, AGENTS Rebrand Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use xiaoming:xiaoming-brainstorming-subagent-driven-development (recommended) or xiaoming:xiaoming-brainstorming-executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebrand README.md, CLAUDE.md, and AGENTS.md to Xiaoming (小明) and translate them into Chinese.

**Architecture:** We will replace all occurrences of "Superpowers" with "Xiaoming" or "小明", update namespaces and URLs, and rewrite the contents of these files in high-quality Chinese.

**Tech Stack:** Markdown, Git

---

### Task 1: Translate and Rebrand CLAUDE.md and AGENTS.md

**Files:**
- Modify: `CLAUDE.md`
- Modify: `AGENTS.md`

- [ ] **Step 1: Write the updated content for CLAUDE.md and AGENTS.md**

Overwrite both [CLAUDE.md](file:///Users/hanjie/IdeaProjects/xiaoming/CLAUDE.md) and [AGENTS.md](file:///Users/hanjie/IdeaProjects/xiaoming/AGENTS.md) with the following content:

```markdown
# 小明 (Xiaoming) — 贡献者指南

## 如果你是一个 AI 代理 (AI Agent)

请停下。在进行任何操作之前，请务必先仔细阅读本节内容。

该仓库的 PR 拒绝率高达 94%。几乎每一个被拒绝的 PR 都是由未阅读或未遵守这些指南的 AI 代理提交的。维护者会在几小时内直接关闭低质量/“胡凑”（slop）的 PR，并常常附带公开评论，比如“该拉取请求是由谎言构成的胡凑之作”。

**你的任务是保护你的真人伙伴免受这种尴尬。** 提交一个低质量的 PR 并不能帮到他们——这不仅会浪费维护者的宝贵时间，抹黑你真人伙伴的声誉，而且该 PR 最终还是会被关闭。这不叫提供帮助，这只是一个让人尴尬的工具。

在针对该仓库开启 PR 之前，你**必须**：

1. **阅读完整的 PR 模板**：位于 `.github/PULL_REQUEST_TEMPLATE.md`，用真实、具体的回答填满每一个小节。严禁使用简写或占位符。
2. **搜索已有的 PR**：无论是开启中还是已关闭的，只要是解决相同问题的。如果已存在重复的 PR，请立即**停止**并告知你的真人伙伴。不要提交重复的 PR。
3. **确认这是一个真实存在的问题**：如果你的真人伙伴只是让你“修复一些问题”或“为这个仓库做点贡献”，而你并没有在实际运行中遇到具体的问题，请予以拒绝。向他们询问到底什么地方坏了、报错信息是什么，以及具体的用户体验如何。
4. **确认改动属于核心功能**：如果改动是特定领域的、特定工具的，或是推广第三方项目的，它应该放在一个独立的插件中。告知你的真人伙伴。
5. **标明你的身份**：在 PR 中公开你使用的模型、运行框架（harness）、框架版本以及所有安装的插件。隐藏 PR 是由代理生成的、或者隐瞒运行环境是直接关闭 PR 的正当理由。
6. **向你的真人伙伴展示完整的 diff 差异**，并在提交前获得他们的**显式批准**。

如果上述任何一项检查未通过，请勿开启 PR。向你的真人伙伴解释为什么这会被拒绝，以及需要做出哪些修改。他们会感谢你帮他们避免了尴尬。

## 拉取请求 (PR) 要求

**每一个 PR 必须完整填写 PR 模板。** 不得将任何小节留空或使用占位符文本。跳过模板小节的 PR 将在不进行任何审查的情况下直接关闭。

**在开启 PR 之前，你必须搜索已有的 PR**（包括开启和已关闭的），以查找是否有人解决过相同或相关的问题。在“Existing PRs”一节中列出你的发现。如果之前的 PR 被关闭了，请具体解释你的方法有什么不同，以及为什么你的方案能取得成功。

**若 PR 未体现任何人类参与的迹象，将被直接关闭。** 人类必须在提交前审查完整的拟议 diff。

**提交者必须标明身份。** 每个 PR 和 Issue 都必须披露用于生成该贡献的模型、运行框架、框架版本和所有安装的插件——或者明确声明这是完全由人手工编写，未使用任何代理。这不是可选的。我们需要知道改动是由什么产生的，以便衡量它：基于文档进行推理的代理生成内容，与基于实际开发会话产生的改动，其衡量标准是不同的。隐藏其编写环境的贡献将被直接关闭。

**所有 PR 必须以 `dev` 分支为目标，而不是 `main`。** `main` 是已发布的稳定分支，所有的活跃开发应首先并入 `dev` 分支。针对 `main` 开启的 PR 会被要求重新指向 `dev` 后才会进行审查。

## 我们不接受的变更

### 第三方依赖

除非是为新的集成平台/载体（例如新的 IDE 或 CLI 工具）添加支持，否则不接受添加可选或必需的第三方项目依赖。小明 (Xiaoming) 在设计上是一个零依赖的插件。如果你的变更需要外部工具或服务，它应该属于它自己的插件。

### 对技能（Skills）的“合规性”修改

我们内部的技能设计哲学与 Anthropic 发布的技能编写指导有所不同。我们针对真实的代理行为，对技能内容进行了广泛的测试与微调。除非有广泛的评测（eval）数据证明该修改能够提升效果，否则我们不接受为了“迎合” Anthropic 官方文档而重构、改写或重新格式化技能的 PR。修改影响行为的核心内容，其门槛非常高。

### 项目特定或个人化的配置

仅对特定项目、团队、领域或工作流有益的技能、钩子（hooks）或配置，不属于核心库。请将这些内容作为独立的插件发布。

### 批量或“广撒网”式的 PR

请勿在单次会话中搜刮 Issue 列表并为多个问题开启 PR。每个 PR 都需要对问题有真正的理解、对前人尝试的调研，以及人类对完整 diff 的审查。凡是显露出批量处理迹象（例如代理被指向 Issue 列表并被告知“修复这些问题”）的 PR 都将被直接关闭。如果你想贡献，请挑选**一个** Issue，深入理解它，并提交高质量的工作。

### 投机性或理论性的修复

每个 PR 必须解决某人实际经历过的真实问题。“我的审查代理标记了这里”或“这在理论上可能会导致问题”并不是一个有效的问题陈述。如果你无法描述出促使该修改的具体会话、错误或用户体验，请不要提交 PR。

### 领域特定的技能

小明 (Xiaoming) 核心库只包含对所有用户（无论其项目类型）都有益的通用技能。用于特定领域（如投资组合构建、预测市场、游戏）、特定工具或特定工作流的技能，属于它们自己的独立插件。问问自己：“这对于从事完全不同项目的人是否有用？”如果不是，请单独发布。

### 分支/Fork 特定的变更

如果你维护了一个包含自定义改动的 fork，请勿开启 PR 来同步你的 fork 或将 fork 特定的改动推送到上游。重新包装项目品牌、添加 fork 特定功能或合并 fork 分支的 PR 将被直接关闭。

### 虚假内容

包含虚假声明、捏造的问题描述或幻想出来的功能的 PR 将被立即关闭。该仓库的 PR 拒绝率高达 94%——维护者已经见识过各种形式 of AI 胡凑。他们一定会注意到。

### 捆绑无关的改动

包含多个不相关改动的 PR 将被关闭。请将它们拆分为独立的 PR。

## 新集成平台/载体支持

如果你的 PR 添加了对新集成平台（IDE、CLI 工具、代理运行器）的支持，你**必须**包含一个证明该集成端到端正常工作的完整会话转录（transcript）。

一个真正的集成应该在会话启动时加载 `xiaoming-using-xiaoming` 引导。引导是技能在正确时刻自动触发的原因。如果没有它，这些技能就只是磁盘上的死重——存在但从未被调用。

**验收测试**：在新载体中开启一个干净的会话，并发送完全相同的用户消息：

> Let's make a react todo list

一个工作正常的集成在编写任何代码之前会**自动触发** `xiaoming`（原 `brainstorming`）技能。在 PR 中贴出完整的会话转录。

**以下情况并非真正的集成，将被直接关闭**：
- 手动将技能文件复制到集成平台中
- 运行时使用 `npx skills` 或类似的临时垫片进行包装
- 任何需要用户在每个会话中手动启用技能的方案
- 任何在上述验收测试中未能自动触发 `xiaoming` 技能的方案

如果你不确定你的集成是否在会话启动时加载了 bootstrap 引导，那它就是没有加载。

## 技能改动需要评估

技能不是散文——它们是塑造代理行为的代码。如果你修改了技能内容：

- 使用 `xiaoming:xiaoming-brainstorming-writing-skills` 技能来开发和测试改动
- 在多个会话中进行对抗性压力测试
- 在 PR 中展示修改前后的评测（eval）结果
- 在没有证据证明改动确实带来提升的情况下，不要修改精心调整过的内容（如红线警告表、合理化清单、“真人伙伴”用语）

## 贡献前先了解项目

在对技能设计、工作流哲学或架构提出建议之前，阅读现有的技能并理解项目的决策。小明 (Xiaoming) 在技能设计、代理行为塑造和术语（例如，“真人伙伴”/“your human partner”是刻意选择的，不能与“用户”/“the user”混用）方面有其自身经过验证的哲学。不理解项目设立初衷、企图重写项目语气或重塑项目方法的改动将被直接拒绝。

## 通用规则

- 提交前仔细阅读 `.github/PULL_REQUEST_TEMPLATE.md`
- 一个 PR 只解决一个问题
- 至少在一个平台上进行测试，并在环境表中报告结果
- 描述你解决的问题，而不仅仅是你改动了什么
```

- [ ] **Step 2: Verify the contents of CLAUDE.md and AGENTS.md**

Run `git diff CLAUDE.md AGENTS.md` to ensure they are identical and translated successfully.

- [ ] **Step 3: Commit Task 1**

Run:
```bash
git add CLAUDE.md AGENTS.md
git commit -m "docs: translate CLAUDE.md and AGENTS.md to Chinese and rebrand to Xiaoming"
```

---

### Task 2: Translate and Rebrand README.md

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Overwrite README.md with the Chinese version**

Overwrite [README.md](file:///Users/hanjie/IdeaProjects/xiaoming/README.md) with the following content:

```markdown
# 小明 (Xiaoming)

小明 (Xiaoming) 是一套专为编码代理（Coding Agents）设计的完整软件开发方法论，它建立在可组合的技能集以及一系列引导代理必须使用这些技能的初始指令基础之上。

## 快速入门

为你的代理赋予小明技能加持：[Claude Code](#claude-code)、[Codex CLI](#codex-cli)、[Codex App](#codex-app)、[Factory Droid](#factory-droid)、[Gemini CLI](#gemini-cli)、[OpenCode](#opencode)、[Cursor](#cursor)、[GitHub Copilot CLI](#github-copilot-cli)。

## 工作原理

从小伙伴启动编码代理的那一刻起，它就开始发挥作用。一旦代理察觉到你想要构建某些东西，它**不会**直接冲进代码编写中。相反，它会退后一步，向你询问你真正想要实现的目标。

当它从对话中提炼出设计规约（spec）后，会以足够简短、便于阅读和消化的段落逐步展示给你确认。

在你批准了设计之后，你的代理会制定一份详尽的实施计划。这份计划清晰明确，甚至能让一个充满热情、缺乏品味、没有判断力、不了解项目背景且反感写测试的初级工程师轻松遵循。它极力强调真实的红/绿测试驱动开发（TDD）、YAGNI（你不需要它）原则和 DRY（不要重复自己）原则。

接着，一旦你下达“开始（go）”指令，它就会启动**子代理驱动开发（subagent-driven-development）**流程。代理会依次处理每一个工程任务，检查并评审其产出，然后继续向前推进。让 Claude 在不偏离你们共同制定的计划的前提下，自主工作几个小时而无需人类干预，是完全正常的。

这个系统还有很多其他细节，但这正是其核心所在。由于这些技能是自动触发的，你无需进行任何特殊操作，你的编码代理自然就拥有了小明（Xiaoming）的能力。

## 赞助项目

如果小明 (Xiaoming) 确实帮助你完成了能够带来收益的项目，且你愿意支持的话，非常感激你能考虑 [赞助我的开源工作](https://github.com/sponsors/obra)。

感谢！

- Jesse

## 安装指南

不同的集成平台（harness）安装方式有所不同。如果你使用多个平台，请为每个平台分别安装小明 (Xiaoming)。

### Claude Code

小明可直接在官方 Claude 插件市场或小明专用插件市场中获取。

#### 官方市场安装

- 从 Anthropic 的官方插件市场安装插件：

  ```bash
  /plugin install xiaoming@claude-plugins-official
  ```

#### 小明插件市场安装

小明插件市场提供了小明以及其他一些为 Claude Code 设计的相关插件。

- 注册插件市场：

  ```bash
  /plugin marketplace add obra/xiaoming-marketplace
  ```

- 从该市场安装插件：

  ```bash
  /plugin install xiaoming@xiaoming-marketplace
  ```

### Codex CLI

小明可在 [Codex 官方插件市场](https://github.com/openai/plugins) 中获取。

- 打开插件搜索界面：

  ```bash
  /plugins
  ```

- 搜索并选择小明：

  ```bash
  xiaoming
  ```

- 选择 `Install Plugin`（安装插件）。

### Codex App

小明可在 [Codex 官方插件市场](https://github.com/openai/plugins) 中获取。

- 在 Codex 应用程序中，点击侧边栏的“Plugins”。
- 你应该能在“Coding”部分看到 `Xiaoming`。
- 点击 `Xiaoming` 旁的 `+` 号并根据提示完成安装。

### Factory Droid

- 注册插件市场：

  ```bash
  droid plugin marketplace add https://github.com/hj1003862396/xiaoming-brainstorming
  ```

- 安装插件：

  ```bash
  droid plugin install xiaoming@xiaoming
  ```

### Gemini CLI

- 安装扩展：

  ```bash
  gemini extensions install https://github.com/hj1003862396/xiaoming-brainstorming
  ```

- 后续更新：

  ```bash
  gemini extensions update xiaoming
  ```

### OpenCode

OpenCode 使用其自有的插件安装机制；即使你已经在其他集成平台中安装过，也请为 OpenCode 单独安装。

- 向 OpenCode 发送指令：

  ```
  获取并遵循以下链接中的安装说明：https://raw.githubusercontent.com/hj1003862396/xiaoming/refs/heads/main/.opencode/INSTALL.md
  ```

- 详细文档：[docs/README.opencode.md](docs/README.opencode.md)

### Cursor

- 在 Cursor Agent 聊天中，从市场进行安装：

  ```text
  /add-plugin xiaoming
  ```

- 或者在插件市场中搜索 "xiaoming" 进行安装。

### GitHub Copilot CLI

- 注册插件市场：

  ```bash
  copilot plugin marketplace add obra/xiaoming-marketplace
  ```

- 安装插件：

  ```bash
  copilot plugin install xiaoming@xiaoming-marketplace
  ```

## 基础开发工作流

1. **xiaoming**（原 `brainstorming`） - 在编写代码前激活。通过 Socratic 提问精炼粗糙的想法，探索替代方案，并分节展示设计方案进行确认。保存设计规约文档。

2. **using-git-worktrees** - 在设计通过批准后激活。在新的分支上创建隔离的 git 工作区，运行项目初始化，验证测试的干净基线。

3. **writing-plans** - 在获得批准的设计方案后激活。将任务分解为大小适中的子任务（每项约 2-5 分钟）。每个任务都包含准确的文件路径、完整的代码和验证步骤。

4. **subagent-driven-development** 或 **executing-plans** - 在制定好计划后激活。针对每个任务分派全新的子代理并进行双阶段审查（先审查设计规约合规性，再审查代码质量），或分批执行并进行人工确认。

5. **test-driven-development** - 在实施开发期间激活。强制执行 **红-绿-重构** 循环：编写失败测试、查看失败原因、编写最少代码使测试通过、提交。删除在测试前编写的业务代码。

6. **requesting-code-review** - 在任务之间激活。根据计划进行审查，按严重程度报告问题。严重问题将阻止后续推进。

7. **finishing-a-development-branch** - 在任务完成后激活。验证测试，提供集成选项（Merge、PR、保留或废弃），清理 git 工作区。

**代理在进行任何任务前都会检查相关的技能。** 这些是必须遵守的强制性工作流，而非仅供参考的建议。

## 功能构成 (What's Inside)

### 技能库 (Skills Library)

**测试 (Testing)**
- **test-driven-development** - 红-绿-重构循环（包含测试反模式参考）

**调试 (Debugging)**
- **systematic-debugging** - 4 阶段根因分析流程（包括根因追溯、深度防御和基于条件的等待技术）
- **verification-before-completion** - 确保 bug 确实已被修复

**协作模式 (Collaboration)** 
- **xiaoming** - 类似苏格拉底式的设计方案精炼
- **writing-plans** - 详细的开发实施计划
- **executing-plans** - 带有检查点的分批执行
- **dispatching-parallel-agents** - 并发的子代理工作流
- **requesting-code-review** - 提交评审前的核对清单
- **receiving-code-review** - 响应审查反馈
- **using-git-worktrees** - 并行开发分支隔离
- **finishing-a-development-branch** - 合并与 PR 决策工作流
- **subagent-driven-development** - 带有双阶段评审（规约合规和代码质量）的快速迭代流程

**元技能 (Meta)**
- **writing-skills** - 遵循最佳实践创建新技能（包括测试方法论）
- **xiaoming-using-xiaoming** - 引导了解小明技能系统

## 核心开发哲学

- **测试驱动开发 (TDD)** - 永远且必须先编写测试
- **系统化强于随机尝试** - 遵循流程比猜测和运气更靠谱
- **追求极简，降低复杂度** - 简单性是架构的首要目标
- **事实与证据强于主观宣称** - 在宣称成功前必须运行命令进行验证

阅读 [最初的发布声明（英文）](https://blog.fsck.com/2025/10/09/superpowers/)。

## 贡献指南

小明 (Xiaoming) 的常规贡献流程如下。请记住，我们通常不接受新技能的贡献，并且技能的任何更新都必须兼容我们支持的所有编码代理平台。

1. Fork 本仓库
2. 切换到 `dev` 分支
3. 为你的修改创建分支
4. 遵循 `writing-skills` 技能来开发和测试新技能或修改后的技能
5. 提交 PR，并确保完整填写拉取请求模板。

查看 `skills/xiaoming-brainstorming-writing-skills/SKILL.md` 了解完整的指引。

## 更新机制

小明 (Xiaoming) 的更新在一定程度上取决于编码代理平台本身，但通常是自动更新的。

## 开源协议

MIT 协议 - 详情请参阅 LICENSE 文件。

## 社区交流

小明 (Xiaoming) 由 [Jesse Vincent](https://blog.fsck.com) 及 [Prime Radiant](https://primeradiant.com) 的其他伙伴共同打造。

- **Discord**: [加入我们](https://discord.gg/35wsABTejz) 以获取社区支持、交流问题，并分享你用小明构建的成果。
- **问题反馈 (Issues)**: https://github.com/hj1003862396/xiaoming/issues
- **发布通知**: [订阅](https://primeradiant.com/superpowers/) 接收新版本的通知。
```

- [ ] **Step 2: Verify git diff for README.md**

Run `git diff README.md` to verify the translation.

- [ ] **Step 3: Commit Task 2**

Run:
```bash
git add README.md
git commit -m "docs: translate README.md to Chinese and rebrand to Xiaoming"
```

---

### Task 3: Verification and Final Checks

**Files:**
- Modify: `scripts/verify-xiaoming.sh`

- [ ] **Step 1: Check for any dangling "superpowers" references**

Run:
```bash
grep -rn -i "superpowers" README.md CLAUDE.md AGENTS.md || true
```
Expected: Only URLs/links (e.g. blog post link or discord invite link if they contain "superpowers") should match. No namespace or text should refer to Superpowers.

- [ ] **Step 2: Run verification script**

Run:
```bash
./scripts/verify-xiaoming.sh
```
Expected: Verification passed! Rebranding to Xiaoming is successful.
