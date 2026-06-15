# Rename Skills to Xiaoming Prefix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use xiaoming:xiaoming-subagent-driven-development (recommended) or xiaoming:xiaoming-executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rename all skill directories and their元数据 `name` fields under `skills/` to be prefixed with `xiaoming-` (using direct filesystem commands, no git commands) and update all references to keep the plugin fully functional.

**Architecture:** We will physically rename the 14 skill directories, update their frontmatter metadata, rename the slash command configuration, modify loaders/hooks/verification scripts, perform global text substitution for namespace invocations, and update test scripts & prompt files.

**Tech Stack:** Bash, JavaScript, Markdown

---

### Task 1: Rename Skill Directories and metadata name fields

**Files:**
- Modify: `skills/*/SKILL.md` (metadata)

- [ ] **Step 1: Rename the physical directories of all 14 skills**
Run the following filesystem rename commands in sequence:
```bash
mv skills/xiaoming skills/xiaoming-brainstorming
mv skills/using-xiaoming-bootstrap skills/xiaoming-using-xiaoming
mv skills/dispatching-parallel-agents skills/xiaoming-dispatching-parallel-agents
mv skills/executing-plans skills/xiaoming-executing-plans
mv skills/finishing-a-development-branch skills/xiaoming-finishing-a-development-branch
mv skills/receiving-code-review skills/xiaoming-receiving-code-review
mv skills/requesting-code-review skills/xiaoming-requesting-code-review
mv skills/subagent-driven-development skills/xiaoming-subagent-driven-development
mv skills/systematic-debugging skills/xiaoming-systematic-debugging
mv skills/test-driven-development skills/xiaoming-test-driven-development
mv skills/using-git-worktrees skills/xiaoming-using-git-worktrees
mv skills/verification-before-completion skills/xiaoming-verification-before-completion
mv skills/writing-plans skills/xiaoming-writing-plans
mv skills/writing-skills skills/xiaoming-writing-skills
```

- [ ] **Step 2: Update `name` field in metadata frontmatter for each skill**
Update the frontmatter configuration at line 2 in each renamed skill's `SKILL.md`:
* `skills/xiaoming-brainstorming/SKILL.md`:
  `name: xiaoming-brainstorming`
* `skills/xiaoming-using-xiaoming/SKILL.md`:
  `name: xiaoming-using-xiaoming`
* `skills/xiaoming-dispatching-parallel-agents/SKILL.md`:
  `name: xiaoming-dispatching-parallel-agents`
* `skills/xiaoming-executing-plans/SKILL.md`:
  `name: xiaoming-executing-plans`
* `skills/xiaoming-finishing-a-development-branch/SKILL.md`:
  `name: xiaoming-finishing-a-development-branch`
* `skills/xiaoming-receiving-code-review/SKILL.md`:
  `name: xiaoming-receiving-code-review`
* `skills/xiaoming-requesting-code-review/SKILL.md`:
  `name: xiaoming-requesting-code-review`
* `skills/xiaoming-subagent-driven-development/SKILL.md`:
  `name: xiaoming-subagent-driven-development`
* `skills/xiaoming-systematic-debugging/SKILL.md`:
  `name: xiaoming-systematic-debugging`
* `skills/xiaoming-test-driven-development/SKILL.md`:
  `name: xiaoming-test-driven-development`
* `skills/xiaoming-using-git-worktrees/SKILL.md`:
  `name: xiaoming-using-git-worktrees`
* `skills/xiaoming-verification-before-completion/SKILL.md`:
  `name: xiaoming-verification-before-completion`
* `skills/xiaoming-writing-plans/SKILL.md`:
  `name: xiaoming-writing-plans`
* `skills/xiaoming-writing-skills/SKILL.md`:
  `name: xiaoming-writing-skills`

---

### Task 2: Rename and update Slash Command config

**Files:**
- Modify: commands/xiaoming.md [NEW path: `commands/xiaoming-brainstorming.md`]

- [ ] **Step 1: Rename the command file**
Run:
```bash
mv commands/xiaoming.md commands/xiaoming-brainstorming.md
```

- [ ] **Step 2: Update content in `commands/xiaoming-brainstorming.md`**
Replace lines 6-7 of commands/xiaoming-brainstorming.md with:
```markdown
调用 xiaoming:xiaoming-brainstorming 技能，并严格按照其中给出的指引执行。
```

---

### Task 3: Update Loader & Hooks configuration files

**Files:**
- Modify: hooks/session-start
- Modify: .opencode/plugins/xiaoming.js
- Modify: scripts/verify-xiaoming.sh

- [ ] **Step 1: Update `hooks/session-start`**
Replace lines 17-18 in hooks/session-start:
```bash
# Read xiaoming-using-xiaoming content
using_superpowers_content=$(cat "${PLUGIN_ROOT}/skills/xiaoming-using-xiaoming/SKILL.md" 2>&1 || echo "Error reading xiaoming-using-xiaoming skill")
```
And replace the context session banner text at line 35:
```bash
session_context="<EXTREMELY_IMPORTANT>\n你已拥有小明（xiaoming）的技能加持。\n\n**以下是你的 'xiaoming:xiaoming-using-xiaoming' 技能的完整内容 - 这是你使用技能系统的引导。对于所有其他技能，请使用 'Skill' 工具：**\n\n${using_superpowers_escaped}\n\n${warning_escaped}\n</EXTREMELY_IMPORTANT>"
```

- [ ] **Step 2: Update `.opencode/plugins/xiaoming.js`**
Replace line 67 in .opencode/plugins/xiaoming.js:
```javascript
    const skillPath = path.join(xiaomingSkillsDir, 'xiaoming-using-xiaoming', 'SKILL.md');
```
And replace the bootstrap prompt text references at line 88:
```javascript
**IMPORTANT: The xiaoming-using-xiaoming skill content is included below. It is ALREADY LOADED - you are currently following it. Do NOT use the skill tool to load "xiaoming-using-xiaoming" again - that would be redundant.**
```

- [ ] **Step 3: Update `scripts/verify-xiaoming.sh`**
Replace lines 18-20 in scripts/verify-xiaoming.sh:
```bash
check_dir "skills/xiaoming-brainstorming"
check_dir "skills/xiaoming-using-xiaoming"
```
Replace lines 22-26:
```bash
if [ ! -f "commands/xiaoming-brainstorming.md" ]; then
    echo "❌ Slash command missing: commands/xiaoming-brainstorming.md"
    errors=$((errors+1))
else
    echo "✅ Slash command exists: commands/xiaoming-brainstorming.md"
fi
```

---

### Task 4: Global substitution of namespace references

**Files:**
- Modify: `skills/**/*.md`, `docs/**/*.md`, `CLAUDE.md`, `README.md`, `GEMINI.md`

- [ ] **Step 1: Replace skill names in documentation and markdown references**
Globally perform search and replace in all markdown files:
- Replace `xiaoming:xiaoming` $\rightarrow$ `xiaoming:xiaoming-brainstorming`
- Replace `xiaoming:using-xiaoming-bootstrap` $\rightarrow$ `xiaoming:xiaoming-using-xiaoming`
- Replace `using-xiaoming-bootstrap` $\rightarrow$ `xiaoming-using-xiaoming`
- Replace `/xiaoming` $\rightarrow$ `/xiaoming-brainstorming` (only when it refers to the command, e.g. in `README.md` and `CLAUDE.md`)
- Replace the other 12 skill namespaces from `xiaoming:xxx` to `xiaoming:xiaoming-xxx` (e.g. `xiaoming:test-driven-development` $\rightarrow$ `xiaoming:xiaoming-test-driven-development`).

Specifically update the file GEMINI.md:
```markdown
@./skills/xiaoming-using-xiaoming/SKILL.md
@./skills/xiaoming-using-xiaoming/references/gemini-tools.md
```

---

### Task 5: Update Tests configuration and prompt files

**Files:**
- Modify: tests/opencode/test-bootstrap-caching.mjs
- Modify: tests/skill-triggering/run-all.sh
- Modify: tests/explicit-skill-requests/run-all.sh
- Modify: `tests/explicit-skill-requests/prompts/*`
- Modify: `tests/skill-triggering/prompts/*`

- [ ] **Step 1: Update `tests/opencode/test-bootstrap-caching.mjs`**
Replace line 68 in test-bootstrap-caching.mjs:
```javascript
  return String(filePath).replaceAll('\\', '/').includes('xiaoming-using-xiaoming/SKILL.md');
```

- [ ] **Step 2: Update `tests/skill-triggering/run-all.sh`**
Replace lines 10-17 in run-all.sh:
```bash
SKILLS=(
    "xiaoming-systematic-debugging"
    "xiaoming-test-driven-development"
    "xiaoming-writing-plans"
    "xiaoming-dispatching-parallel-agents"
    "xiaoming-executing-plans"
    "xiaoming-requesting-code-review"
)
```

- [ ] **Step 3: Update `tests/explicit-skill-requests/run-all.sh`**
Modify run-all.sh to invoke `xiaoming-subagent-driven-development`, `xiaoming-systematic-debugging`, and `xiaoming-brainstorming` instead of the old names.
Replace lines 17-58:
```bash
# Test: xiaoming-subagent-driven-development, please
echo ">>> Test 1: subagent-driven-development-please"
if "$SCRIPT_DIR/run-test.sh" "xiaoming-subagent-driven-development" "$PROMPTS_DIR/xiaoming-subagent-driven-development-please.txt"; then
    PASSED=$((PASSED + 1))
    RESULTS="$RESULTS\nPASS: subagent-driven-development-please"
else
    FAILED=$((FAILED + 1))
    RESULTS="$RESULTS\nFAIL: subagent-driven-development-please"
fi
echo ""

# Test: use xiaoming-systematic-debugging
echo ">>> Test 2: use-systematic-debugging"
if "$SCRIPT_DIR/run-test.sh" "xiaoming-systematic-debugging" "$PROMPTS_DIR/use-xiaoming-systematic-debugging.txt"; then
    PASSED=$((PASSED + 1))
    RESULTS="$RESULTS\nPASS: use-systematic-debugging"
else
    FAILED=$((FAILED + 1))
    RESULTS="$RESULTS\nFAIL: use-systematic-debugging"
fi
echo ""

# Test: please use xiaoming-brainstorming
echo ">>> Test 3: please-use-xiaoming"
if "$SCRIPT_DIR/run-test.sh" "xiaoming-brainstorming" "$PROMPTS_DIR/please-use-xiaoming-brainstorming.txt"; then
    PASSED=$((PASSED + 1))
    RESULTS="$RESULTS\nPASS: please-use-xiaoming"
else
    FAILED=$((FAILED + 1))
    RESULTS="$RESULTS\nFAIL: please-use-xiaoming"
fi
echo ""

# Test: mid-conversation execute plan
echo ">>> Test 4: mid-conversation-execute-plan"
if "$SCRIPT_DIR/run-test.sh" "xiaoming-subagent-driven-development" "$PROMPTS_DIR/mid-conversation-execute-plan.txt"; then
    PASSED=$((PASSED + 1))
    RESULTS="$RESULTS\nPASS: mid-conversation-execute-plan"
else
    FAILED=$((FAILED + 1))
    RESULTS="$RESULTS\nFAIL: mid-conversation-execute-plan"
fi
```

- [ ] **Step 4: Rename and update Prompt files**
Run physical renames on tests prompts:
```bash
mv tests/skill-triggering/prompts/dispatching-parallel-agents.txt tests/skill-triggering/prompts/xiaoming-dispatching-parallel-agents.txt
mv tests/skill-triggering/prompts/executing-plans.txt tests/skill-triggering/prompts/xiaoming-executing-plans.txt
mv tests/skill-triggering/prompts/requesting-code-review.txt tests/skill-triggering/prompts/xiaoming-requesting-code-review.txt
mv tests/skill-triggering/prompts/systematic-debugging.txt tests/skill-triggering/prompts/xiaoming-systematic-debugging.txt
mv tests/skill-triggering/prompts/test-driven-development.txt tests/skill-triggering/prompts/xiaoming-test-driven-development.txt
mv tests/skill-triggering/prompts/writing-plans.txt tests/skill-triggering/prompts/xiaoming-writing-plans.txt

mv tests/explicit-skill-requests/prompts/subagent-driven-development-please.txt tests/explicit-skill-requests/prompts/xiaoming-subagent-driven-development-please.txt
mv tests/explicit-skill-requests/prompts/please-use-xiaoming.txt tests/explicit-skill-requests/prompts/please-use-xiaoming-brainstorming.txt
mv tests/explicit-skill-requests/prompts/use-systematic-debugging.txt tests/explicit-skill-requests/prompts/use-xiaoming-systematic-debugging.txt
```
Update contents of:
* `tests/explicit-skill-requests/prompts/please-use-xiaoming-brainstorming.txt`:
  `please use the xiaoming-brainstorming skill to help me think through this feature`
* `tests/explicit-skill-requests/prompts/use-xiaoming-systematic-debugging.txt`:
  `use xiaoming-systematic-debugging to figure out what's wrong`

---

### Task 6: Verification

- [ ] **Step 1: Run verification script**
Run: `./scripts/verify-xiaoming.sh`
Expected: Verification passed successfully.

- [ ] **Step 2: Run unit and trigger tests**
Run:
```bash
./tests/skill-triggering/run-all.sh
./tests/explicit-skill-requests/run-all.sh
```
Expected: All tests pass.
