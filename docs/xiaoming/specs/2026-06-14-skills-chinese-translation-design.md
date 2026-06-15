# 技能文件全量中文化设计文档

## 背景

`xiaoming` 项目的 `skills/` 目录下包含 14 个技能文件夹，约 37 个 Markdown 文件，目前全部为英文。用户希望将这些技能文件翻译为中文，以便中文用户阅读和理解。

## 目标

将所有技能说明文档翻译成中文，技术术语采用「中文（英文括注）」格式，保留代码块、文件路径、系统调用名称等不变，确保翻译后的技能文件结构完整、语义准确、风格统一。

## 翻译范围

### 翻译文件（约 25 个）

| 技能文件夹 | 翻译文件 |
|---|---|
| `xiaoming` | `SKILL.md`、`spec-document-reviewer-prompt.md`、`visual-companion.md` |
| `dispatching-parallel-agents` | `SKILL.md` |
| `executing-plans` | `SKILL.md` |
| `finishing-a-development-branch` | `SKILL.md` |
| `receiving-code-review` | `SKILL.md` |
| `requesting-code-review` | `SKILL.md`、`code-reviewer.md` |
| `subagent-driven-development` | `SKILL.md`、`code-quality-reviewer-prompt.md`、`implementer-prompt.md`、`spec-reviewer-prompt.md` |
| `systematic-debugging` | `SKILL.md`、`condition-based-waiting.md`、`defense-in-depth.md`、`root-cause-tracing.md` |
| `test-driven-development` | `SKILL.md`、`testing-anti-patterns.md` |
| `using-git-worktrees` | `SKILL.md` |
| `xiaoming-using-xiaoming` | `SKILL.md`、`references/codex-tools.md`、`references/copilot-tools.md`、`references/gemini-tools.md` |
| `verification-before-completion` | `SKILL.md` |
| `writing-plans` | `SKILL.md`、`plan-document-reviewer-prompt.md` |
| `writing-skills` | `SKILL.md`、`anthropic-best-practices.md`、`persuasion-principles.md`、`testing-skills-with-subagents.md`、`examples/CLAUDE_MD_TESTING.md` |

### 跳过文件（评测/历史文件，翻译会破坏其有效性）

- `systematic-debugging/test-academic.md`
- `systematic-debugging/test-pressure-1.md`
- `systematic-debugging/test-pressure-2.md`
- `systematic-debugging/test-pressure-3.md`
- `systematic-debugging/CREATION-LOG.md`

## 翻译规则

### 1. 保留英文不翻译

- YAML frontmatter 中的 `name:` 字段（影响系统调用识别）
- 所有代码块（` ``` ` 围栏内）的内容
- 文件路径（如 `docs/xiaoming/specs/YYYY-MM-DD-<topic>-design.md`）
- Shell 命令、变量名、配置项
- XML/HTML 标签名本身（如 `<HARD-GATE>`、`</HARD-GATE>`）
- dot/mermaid 图的属性关键字（`shape=box`、`label=` 等语法）

### 2. YAML frontmatter 翻译策略

```yaml
# 保留 name 字段（英文），翻译 description 字段
name: brainstorming          # ← 保留英文
description: "中文描述..."   # ← 翻译成中文
```

### 3. 强调语气翻译映射

| 英文 | 中文译法 |
|---|---|
| `DO NOT` / `Do NOT` | **绝对不得** |
| `MUST` | **必须** |
| `NEVER` | **永远不要** |
| `ALWAYS` | **始终** |
| `CRITICAL` | **关键** |
| `IMPORTANT` | **重要** |
| `WARNING` | **警告** |

### 4. 统一术语表

| 英文术语 | 中文译法 |
|---|---|
| HARD-GATE | 硬性关卡 (HARD-GATE) |
| Anti-Pattern | 反模式 (Anti-Pattern) |
| your human partner | 你的真人伙伴 |
| YAGNI | YAGNI（你不会需要它） |
| brainstorming | 头脑风暴 (brainstorming) |
| Visual Companion | 可视化伴侣 (Visual Companion) |
| worktree | 工作树 (worktree) |
| subagent | 子代理 (subagent) |
| spec | 规格文档 (spec) |
| implementation plan | 实施计划 (implementation plan) |
| skill | 技能 (skill) |
| checklist | 检查清单 (checklist) |
| scaffold | 脚手架 (scaffold) |
| commit | 提交 (commit) |
| diff | 差异 (diff) |
| branch | 分支 (branch) |
| worktree | 工作树 (worktree) |
| trade-off | 权衡 (trade-off) |
| root cause | 根本原因 (root cause) |
| red herring | 错误线索 (red herring) |
| regression | 回归 (regression) |
| mock / stub | 模拟 (mock) / 桩 (stub) |

### 5. 流程图节点翻译规则

dot/mermaid 流程图中：
- 节点标签（引号内的文字）翻译成中文
- 语法关键字（`shape=`、`label=`、`->`、`[`、`]` 等）保留英文

示例：
```dot
# 翻译前
"Explore project context" [shape=box];

# 翻译后
"探索项目上下文" [shape=box];
```

## 质量要求

1. **语义准确**：不得改变原文的行为指令含义，尤其是强制性约束
2. **术语一致**：全部文件严格遵循上述术语表，不得自行造词
3. **结构完整**：不得删除任何章节、条目或代码块
4. **风格统一**：中文使用书面语，不使用口语化表达

## 执行顺序建议

优先翻译主技能文件（各文件夹的 `SKILL.md`），再翻译辅助文档（`*-prompt.md`、参考文档等）。建议按以下顺序执行，从简单到复杂：

1. `xiaoming/SKILL.md`（已部分中文化，补全正文）
2. 独立 `SKILL.md` 类（每个仅一个文件的技能）
3. 含多文件的技能（`subagent-driven-development`、`writing-skills`、`systematic-debugging`）
4. `xiaoming-using-xiaoming/references/` 工具参考文档

## 不在本次范围内

- 修改技能的行为逻辑或内容
- 翻译 `AGENTS.md`、`README.md`、`CLAUDE.md` 等项目根目录文件
- 翻译评测测试文件（`test-*.md`）
- 提交 git commit
