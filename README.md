# 小明 (Xiaoming)

小明 (Xiaoming) 是一套专为编码代理（Coding Agents）设计的完整软件开发方法论，它建立在可组合的技能集以及一系列引导代理必须使用 these 技能的初始指令基础之上。

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
  droid plugin marketplace add https://github.com/hj1003862396/xiaoming
  ```

- 安装插件：

  ```bash
  droid plugin install xiaoming@xiaoming
  ```

### Gemini CLI

- 安装扩展：

  ```bash
  gemini extensions install https://github.com/hj1003862396/xiaoming
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
- **using-xiaoming-bootstrap** - 引导了解小明技能系统

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

查看 `skills/writing-skills/SKILL.md` 了解完整的指引。

## 更新机制

小明 (Xiaoming) 的更新在一定程度上取决于编码代理平台本身，但通常是自动更新的。

## 开源协议

MIT 协议 - 详情请参阅 LICENSE 文件。

## 社区交流

小明 (Xiaoming) 由 [Jesse Vincent](https://blog.fsck.com) 及 [Prime Radiant](https://primeradiant.com) 的其他伙伴共同打造。

- **Discord**: [加入我们](https://discord.gg/35wsABTejz) 以获取社区支持、交流问题，并分享你用小明构建的成果。
- **问题反馈 (Issues)**: https://github.com/hj1003862396/xiaoming/issues
- **发布通知**: [订阅](https://primeradiant.com/superpowers/) 接收新版本的通知。
