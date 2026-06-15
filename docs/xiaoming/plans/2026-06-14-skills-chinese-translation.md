# 技能文件全量中文化实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use xiaoming:xiaoming-brainstorming-subagent-driven-development (recommended) or xiaoming:xiaoming-brainstorming-executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将 `skills/` 目录下所有技能的 Markdown 文件翻译为中文，跳过评测测试文件。

**Architecture:** 逐文件就地修改（in-place），保留文件结构和格式，仅替换自然语言内容。无需新建文件，无需 git commit。

**Tech Stack:** 纯文本翻译，无代码变更，使用统一术语表（见规格文档）。

---

## 术语表（所有任务共用）

| 英文 | 中文 |
|---|---|
| DO NOT / Do NOT | 绝对不得 |
| MUST | 必须 |
| NEVER | 永远不要 |
| ALWAYS | 始终 |
| HARD-GATE | 硬性关卡 (HARD-GATE) |
| Anti-Pattern | 反模式 (Anti-Pattern) |
| your human partner | 你的真人伙伴 |
| YAGNI | YAGNI（你不会需要它） |
| brainstorming / Brainstorming | 头脑风暴 (brainstorming) |
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
| trade-off | 权衡 (trade-off) |
| root cause | 根本原因 (root cause) |
| red herring | 错误线索 (red herring) |
| regression | 回归问题 (regression) |
| mock / stub | 模拟 (mock) / 桩 (stub) |

## 翻译原则（所有任务共用）

- YAML `name:` 字段**保留英文**，`description:` 字段翻译为中文
- 代码块（` ``` ` 围栏内）**保留英文**
- 文件路径、命令、变量名**保留英文**
- `<HARD-GATE>`、`</HARD-GATE>` 等 XML 标签名**保留英文**
- dot 流程图节点标签（引号内文字）翻译为中文，语法关键字保留英文
- 严格遵循术语表，不自行造词

---

## Task 1: 翻译 `xiaoming/SKILL.md`

**Files:**
- Modify: `skills/xiaoming-brainstorming/SKILL.md`

- [ ] **步骤 1：翻译 SKILL.md 正文**

  将第 6 行起的英文正文全部翻译为中文。`name` 字段保留英文，`description` 字段已是中文无需修改。

  翻译要点：
  - 标题 `# Brainstorming Ideas Into Designs` → `# 将想法转化为设计`
  - `<HARD-GATE>` 块内文字翻译，但标签本身保留
  - dot 流程图节点标签翻译（见下方对照）
  - 章节标题、正文、要点列表全部翻译

  流程图节点对照：
  ```
  "Explore project context" → "探索项目上下文"
  "Visual questions ahead?" → "有视觉类问题？"
  "Offer Visual Companion\n(own message, no other content)" → "提供可视化伴侣\n（单独消息，不含其他内容）"
  "Ask clarifying questions" → "提出澄清问题"
  "Propose 2-3 approaches" → "提出 2-3 个方案"
  "Present design sections" → "呈现设计章节"
  "User approves design?" → "用户批准设计？"
  "Write design doc" → "撰写设计文档"
  "Spec self-review\n(fix inline)" → "规格文档自我审查\n（就地修复）"
  "User reviews spec?" → "用户审查规格文档？"
  "Invoke writing-plans skill" → "调用 writing-plans 技能"
  ```

  边标签对照：
  ```
  "yes" → "是"
  "no" → "否"
  "no, revise" → "否，修改"
  "approved" → "已批准"
  "changes requested" → "要求修改"
  ```

- [ ] **步骤 2：验证文件结构完整**

  确认：
  1. YAML frontmatter 的 `name: xiaoming` 未被修改
  2. 所有代码块内容未被翻译
  3. 文件路径（如 `docs/xiaoming/specs/YYYY-MM-DD-<topic>-design.md`）未被修改
  4. `<HARD-GATE>` 标签名未被修改

---

## Task 2: 翻译 `xiaoming/spec-document-reviewer-prompt.md` 和 `xiaoming/visual-companion.md`

**Files:**
- Modify: `skills/xiaoming-brainstorming/spec-document-reviewer-prompt.md`
- Modify: `skills/xiaoming-brainstorming/visual-companion.md`

- [ ] **步骤 1：翻译 `spec-document-reviewer-prompt.md`**

  全文翻译为中文，保留代码块和路径。

- [ ] **步骤 2：翻译 `visual-companion.md`**

  全文翻译为中文，保留代码块、路径和命令。注意保留 Visual Companion 相关技术说明的准确性。

---

## Task 3: 翻译独立技能（每个仅有 SKILL.md）

每个技能逐一翻译 SKILL.md。

**Files:**
- Modify: `skills/xiaoming-brainstorming-dispatching-parallel-agents/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-executing-plans/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-finishing-a-development-branch/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-receiving-code-review/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-using-git-worktrees/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-verification-before-completion/SKILL.md`

- [ ] **步骤 1：翻译 `dispatching-parallel-agents/SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 2：翻译 `executing-plans/SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 3：翻译 `finishing-a-development-branch/SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 4：翻译 `receiving-code-review/SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 5：翻译 `using-git-worktrees/SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 6：翻译 `verification-before-completion/SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

---

## Task 4: 翻译 `requesting-code-review/`

**Files:**
- Modify: `skills/xiaoming-brainstorming-requesting-code-review/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-requesting-code-review/code-reviewer.md`

- [ ] **步骤 1：翻译 `SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 2：翻译 `code-reviewer.md`**

  全文翻译，保留代码块、路径。

---

## Task 5: 翻译 `subagent-driven-development/`

**Files:**
- Modify: `skills/xiaoming-brainstorming-subagent-driven-development/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-subagent-driven-development/code-quality-reviewer-prompt.md`
- Modify: `skills/xiaoming-brainstorming-subagent-driven-development/implementer-prompt.md`
- Modify: `skills/xiaoming-brainstorming-subagent-driven-development/spec-reviewer-prompt.md`

- [ ] **步骤 1：翻译 `SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 2：翻译 `code-quality-reviewer-prompt.md`**

  全文翻译，保留代码块和路径。

- [ ] **步骤 3：翻译 `implementer-prompt.md`**

  全文翻译，保留代码块和路径。

- [ ] **步骤 4：翻译 `spec-reviewer-prompt.md`**

  全文翻译，保留代码块和路径。

---

## Task 6: 翻译 `systematic-debugging/`（跳过测试文件）

**Files:**
- Modify: `skills/xiaoming-brainstorming-systematic-debugging/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-systematic-debugging/condition-based-waiting.md`
- Modify: `skills/xiaoming-brainstorming-systematic-debugging/defense-in-depth.md`
- Modify: `skills/xiaoming-brainstorming-systematic-debugging/root-cause-tracing.md`
- Skip: `test-academic.md`、`test-pressure-1/2/3.md`、`CREATION-LOG.md`

- [ ] **步骤 1：翻译 `SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 2：翻译 `condition-based-waiting.md`**

  全文翻译，保留代码块和路径。

- [ ] **步骤 3：翻译 `defense-in-depth.md`**

  全文翻译，保留代码块和路径。

- [ ] **步骤 4：翻译 `root-cause-tracing.md`**

  全文翻译，保留代码块和路径。

---

## Task 7: 翻译 `test-driven-development/`

**Files:**
- Modify: `skills/xiaoming-brainstorming-test-driven-development/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-test-driven-development/testing-anti-patterns.md`

- [ ] **步骤 1：翻译 `SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 2：翻译 `testing-anti-patterns.md`**

  全文翻译，保留代码块和路径。

---

## Task 8: 翻译 `xiaoming-using-xiaoming/`

**Files:**
- Modify: `skills/xiaoming-brainstorming-using-xiaoming/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-using-xiaoming/references/codex-tools.md`
- Modify: `skills/xiaoming-brainstorming-using-xiaoming/references/copilot-tools.md`
- Modify: `skills/xiaoming-brainstorming-using-xiaoming/references/gemini-tools.md`

- [ ] **步骤 1：翻译 `SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 2：翻译 `references/codex-tools.md`**

  全文翻译，保留代码块、路径和命令。

- [ ] **步骤 3：翻译 `references/copilot-tools.md`**

  全文翻译，保留代码块、路径和命令。

- [ ] **步骤 4：翻译 `references/gemini-tools.md`**

  全文翻译，保留代码块、路径和命令。

---

## Task 9: 翻译 `writing-plans/`

**Files:**
- Modify: `skills/xiaoming-brainstorming-writing-plans/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-writing-plans/plan-document-reviewer-prompt.md`

- [ ] **步骤 1：翻译 `SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。注意计划文档头部模板（Plan Document Header）内的模板文字也应翻译为中文。

- [ ] **步骤 2：翻译 `plan-document-reviewer-prompt.md`**

  全文翻译，保留代码块和路径。

---

## Task 10: 翻译 `writing-skills/`

**Files:**
- Modify: `skills/xiaoming-brainstorming-writing-skills/SKILL.md`
- Modify: `skills/xiaoming-brainstorming-writing-skills/anthropic-best-practices.md`
- Modify: `skills/xiaoming-brainstorming-writing-skills/persuasion-principles.md`
- Modify: `skills/xiaoming-brainstorming-writing-skills/testing-skills-with-subagents.md`
- Modify: `skills/xiaoming-brainstorming-writing-skills/examples/CLAUDE_MD_TESTING.md`

- [ ] **步骤 1：翻译 `SKILL.md`**

  全文翻译，保留代码块、路径、YAML `name` 字段。

- [ ] **步骤 2：翻译 `anthropic-best-practices.md`**

  全文翻译，保留代码块和路径。

- [ ] **步骤 3：翻译 `persuasion-principles.md`**

  全文翻译，保留代码块和路径。

- [ ] **步骤 4：翻译 `testing-skills-with-subagents.md`**

  全文翻译，保留代码块和路径。

- [ ] **步骤 5：翻译 `examples/CLAUDE_MD_TESTING.md`**

  全文翻译，保留代码块和路径。

---

## 验证检查（所有任务完成后）

- [ ] 随机抽查 3 个文件，确认代码块内容未被翻译
- [ ] 确认所有 YAML `name:` 字段仍为英文
- [ ] 确认所有文件路径引用未被翻译
- [ ] 确认 `<HARD-GATE>` 标签名未被修改
