# Xiaoming (小明) Rebranding Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use xiaoming:xiaoming-brainstorming-subagent-driven-development (recommended) or xiaoming:xiaoming-brainstorming-executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fully rebrand the xiaoming project to xiaoming, rename directories, translate skill descriptions to Chinese, map the `/xiaoming` slash command to the brainstorming workflow, and update all internal namespaces and references.

**Architecture:** We will rename key directories (using Git to maintain history), update manifests, update the `session-start` hook template, replace all namespace prefixes (`xiaoming:` -> `xiaoming:`), and update the frontmatter of all `SKILL.md` files with localized descriptions. Finally, a verification script will be created to ensure no dangling references exist.

**Tech Stack:** Bash, JSON, Markdown, Git

---

### Task 1: Rename Directories and Update GEMINI.md

**Files:**
- Modify: `GEMINI.md`
- Rename: `skills/xiaoming-brainstorming-using-xiaoming` -> `skills/xiaoming-brainstorming-using-xiaoming`
- Rename: `skills/brainstorming` -> `skills/xiaoming-brainstorming`
- Rename: `docs/xiaoming` -> `docs/xiaoming`

- [ ] **Step 1: Modify GEMINI.md**

Update the bootstrap pointers in [GEMINI.md](file:///Users/hanjie/IdeaProjects/xiaoming/GEMINI.md):
```markdown
@./skills/xiaoming-brainstorming-using-xiaoming/SKILL.md
@./skills/xiaoming-brainstorming-using-xiaoming/references/gemini-tools.md
```

- [ ] **Step 2: Run git mv commands to rename directories**

Run:
```bash
git mv skills/xiaoming-brainstorming-using-xiaoming skills/xiaoming-brainstorming-using-xiaoming
git mv skills/brainstorming skills/xiaoming-brainstorming
git mv docs/xiaoming-brainstorming docs/xiaoming-brainstorming
```
Expected: Folders are staged for rename in Git.

- [ ] **Step 3: Verify directory renames**

Run:
```bash
ls -la skills/xiaoming-brainstorming-using-xiaoming/SKILL.md
ls -la skills/xiaoming-brainstorming/SKILL.md
ls -la docs/xiaoming/specs/2026-06-14-rebrand-to-xiaoming-design.md
```
Expected: All files are accessible at their new paths.

- [ ] **Step 4: Commit**

Run:
```bash
git add GEMINI.md
git commit -m "refactor: rename folders and update GEMINI.md for xiaoming"
```

---

### Task 2: Update Manifest Files to "xiaoming"

**Files:**
- Modify: `.cursor-plugin/plugin.json`
- Modify: `.claude-plugin/plugin.json`
- Modify: `.codex-plugin/plugin.json`
- Modify: `gemini-extension.json`

- [ ] **Step 1: Modify `.cursor-plugin/plugin.json`**

Update [plugin.json](file:///Users/hanjie/IdeaProjects/xiaoming/.cursor-plugin/plugin.json) content:
```json
{
  "name": "xiaoming",
  "displayName": "Xiaoming",
  "description": "核心技能库：测试驱动开发、系统调试、协作模式与最佳实践流程",
  "version": "5.1.0",
  "author": {
    "name": "Jesse Vincent",
    "email": "jesse@fsck.com"
  },
  "homepage": "https://github.com/obra/xiaoming",
  "repository": "https://github.com/obra/xiaoming",
  "license": "MIT",
  "keywords": [
    "skills",
    "tdd",
    "debugging",
    "collaboration",
    "best-practices",
    "workflows"
  ],
  "skills": "./skills/",
  "agents": "./agents/",
  "commands": "./commands/",
  "hooks": "./hooks/hooks-cursor.json"
}
```

- [ ] **Step 2: Modify `.claude-plugin/plugin.json`**

Update [plugin.json](file:///Users/hanjie/IdeaProjects/xiaoming/.claude-plugin/plugin.json) content:
```json
{
  "name": "xiaoming",
  "description": "小明（Xiaoming）核心技能库：测试驱动开发、系统调试、协作模式与最佳实践",
  "version": "5.1.0",
  "author": {
    "name": "Jesse Vincent",
    "email": "jesse@fsck.com"
  },
  "homepage": "https://github.com/obra/xiaoming",
  "repository": "https://github.com/obra/xiaoming",
  "license": "MIT",
  "keywords": [
    "skills",
    "tdd",
    "debugging",
    "collaboration",
    "best-practices",
    "workflows"
  ]
}
```

- [ ] **Step 3: Modify `.codex-plugin/plugin.json`**

Update [plugin.json](file:///Users/hanjie/IdeaProjects/xiaoming/.codex-plugin/plugin.json) content:
```json
{
  "name": "xiaoming",
  "version": "5.1.0",
  "description": "小明（Xiaoming）核心技能库：测试驱动开发、系统调试、协作模式与最佳实践",
  "author": {
    "name": "Jesse Vincent",
    "email": "jesse@fsck.com",
    "url": "https://github.com/obra"
  },
  "homepage": "https://github.com/obra/xiaoming",
  "repository": "https://github.com/obra/xiaoming",
  "license": "MIT",
  "keywords": [
    "brainstorming",
    "subagent-driven-development",
    "skills",
    "planning",
    "tdd",
    "debugging",
    "code-review",
    "workflow"
  ],
  "skills": "./skills/",
  "interface": {
    "displayName": "小明 (Xiaoming)",
    "shortDescription": "规划、测试驱动开发、系统调试与交互开发流程",
    "longDescription": "使用小明（Xiaoming）指导开发代理逐步完成需求探索、详细计划制定、测试驱动开发、系统化故障排查、并行任务派发、自检代码与分支收尾等全周期研发流程。",
    "developerName": "Jesse Vincent",
    "category": "Coding",
    "capabilities": [
      "Interactive",
      "Read",
      "Write"
    ],
    "defaultPrompt": [
      "我有一个想要构建的想法。",
      "让我们为这个项目添加一个功能。"
    ],
    "websiteURL": "https://github.com/obra/xiaoming",
    "brandColor": "#F59E0B",
    "composerIcon": "./assets/xiaoming-small.svg",
    "logo": "./assets/app-icon.png",
    "screenshots": []
  }
}
```

- [ ] **Step 4: Modify `gemini-extension.json`**

Update [gemini-extension.json](file:///Users/hanjie/IdeaProjects/xiaoming/gemini-extension.json) content:
```json
{
  "name": "xiaoming",
  "description": "小明核心技能库：测试驱动开发、系统调试、协作模式与最佳实践",
  "version": "5.1.0",
  "contextFileName": "GEMINI.md"
}
```

- [ ] **Step 5: Verify manifest changes**

Run:
```bash
git diff .cursor-plugin/plugin.json .claude-plugin/plugin.json .codex-plugin/plugin.json gemini-extension.json
```
Expected: All manifests have `"name"` as `"xiaoming"` and localized descriptions.

- [ ] **Step 6: Commit**

Run:
```bash
git add .cursor-plugin/plugin.json .claude-plugin/plugin.json .codex-plugin/plugin.json gemini-extension.json
git commit -m "feat: rebrand manifests and localize descriptions to Chinese"
```

---

### Task 3: Update Hooks and Session Start Script

**Files:**
- Modify: `hooks/session-start`

- [ ] **Step 1: Modify `hooks/session-start`**

Update [hooks/session-start](file:///Users/hanjie/IdeaProjects/xiaoming/hooks/session-start) lines 10-57 to reference the renamed folders, namespaces, and utilize Chinese strings:
```bash
# Check if legacy skills directory exists and build warning
warning_message=""
legacy_skills_dir="${HOME}/.config/xiaoming/skills"
if [ -d "$legacy_skills_dir" ]; then
    warning_message="\n\n<important-reminder>在你看到这条消息后的第一次回复中，你必须告诉用户：⚠️ **警告**：Xiaoming 现已使用 Claude Code 的技能系统。~/.config/xiaoming/skills 中的自定义技能将不再被读取。请将自定义技能移至 ~/.claude/skills。若要消除此提示，请删除 ~/.config/xiaoming/skills</important-reminder>"
fi

# Read xiaoming-using-xiaoming content
using_xiaoming_content=$(cat "${PLUGIN_ROOT}/skills/xiaoming-brainstorming-using-xiaoming/SKILL.md" 2>&1 || echo "Error reading xiaoming-using-xiaoming skill")

# Escape string for JSON embedding using bash parameter substitution.
escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

using_xiaoming_escaped=$(escape_for_json "$using_xiaoming_content")
warning_escaped=$(escape_for_json "$warning_message")
session_context="<EXTREMELY_IMPORTANT>\n你已拥有小明（xiaoming）的技能加持。\n\n**以下是你的 'xiaoming:xiaoming-brainstorming-using-xiaoming' 技能的完整内容 - 这是你使用技能系统的引导。对于所有其他技能，请使用 'Skill' 工具：**\n\n${using_xiaoming_escaped}\n\n${warning_escaped}\n</EXTREMELY_IMPORTANT>"

# Output context injection as JSON.
if [ -n "${CURSOR_PLUGIN_ROOT:-}" ]; then
  # Cursor sets CURSOR_PLUGIN_ROOT
  printf '{\n  "additional_context": "%s"\n}\n' "$session_context"
elif [ -n "${CLAUDE_PLUGIN_ROOT:-}" ] && [ -z "${COPILOT_CLI:-}" ]; then
  # Claude Code sets CLAUDE_PLUGIN_ROOT without COPILOT_CLI
  printf '{\n  "hookSpecificOutput": {\n    "hookEventName": "SessionStart",\n    "additionalContext": "%s"\n  }\n}\n' "$session_context"
else
  # Copilot CLI or unknown platform
  printf '{\n  "additionalContext": "%s"\n}\n' "$session_context"
fi
```

- [ ] **Step 2: Verify hooks script**

Run:
```bash
git diff hooks/session-start
```
Expected: Output shows path and message changes pointing to `xiaoming-using-xiaoming` in Chinese.

- [ ] **Step 3: Commit**

Run:
```bash
git add hooks/session-start
git commit -m "feat: localize hook messages and point session-start to xiaoming-using-xiaoming"
```

---

### Task 4: Global Namespace and Call Replacements

**Files:**
- Modify: Multiple `SKILL.md` and Markdown files referencing `xiaoming:` prefix.

- [ ] **Step 1: Perform replacement of xiaoming: namespace in all skill markdown files**

Run a recursive perl/sed replacement on `.md` files in the `skills` directory:
```bash
find skills -type f -name "*.md" -exec perl -pi -e 's/xiaoming:/xiaoming:/g' {} +
find docs -type f -name "*.md" -exec perl -pi -e 's/xiaoming:/xiaoming:/g' {} +
```
Expected: All skill namespacing calls now use `xiaoming:` instead of `xiaoming:`.

- [ ] **Step 2: Replace all references to xiaoming:xiaoming-brainstorming with xiaoming:xiaoming-brainstorming**

Run:
```bash
find skills -type f -name "*.md" -exec perl -pi -e 's/xiaoming:xiaoming-brainstorming/xiaoming:xiaoming-brainstorming/g' {} +
find docs -type f -name "*.md" -exec perl -pi -e 's/xiaoming:xiaoming-brainstorming/xiaoming:xiaoming-brainstorming/g' {} +
```
Expected: Call points references to the brainstorming skill correctly target `xiaoming:xiaoming-brainstorming`.

- [ ] **Step 3: Replace all references to xiaoming:xiaoming-brainstorming-using-xiaoming with xiaoming:xiaoming-brainstorming-using-xiaoming**

Run:
```bash
find skills -type f -name "*.md" -exec perl -pi -e 's/xiaoming:xiaoming-brainstorming-using-xiaoming/xiaoming:xiaoming-brainstorming-using-xiaoming/g' {} +
find docs -type f -name "*.md" -exec perl -pi -e 's/xiaoming:xiaoming-brainstorming-using-xiaoming/xiaoming:xiaoming-brainstorming-using-xiaoming/g' {} +
```
Expected: Bootstrap pointers target the renamed namespace.

- [ ] **Step 4: Verify replacements with grep**

Run:
```bash
grep -rn "xiaoming:" skills/ || true
grep -rn "xiaoming:xiaoming-brainstorming" skills/ || true
```
Expected: No lines outputted. All namespaces fully migrated.

- [ ] **Step 5: Commit**

Run:
```bash
git add skills/ docs/
git commit -m "refactor: rename xiaoming namespaces to xiaoming across skills and docs"
```

---

### Task 5: Chinese Description Translation in SKILL.md Files

**Files:**
- Modify: `skills/*/SKILL.md`

- [ ] **Step 1: Update descriptions in SKILL.md files**

Edit descriptions in the YAML frontmatter headers of all `SKILL.md` files:

1. **`skills/xiaoming-brainstorming/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "在进行任何创造性工作（如创建特性、构建组件、添加功能或修改行为）之前，您必须使用此技能。在实施前探索用户意图、需求和设计。"
   ```
2. **`skills/xiaoming-brainstorming-using-xiaoming/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "在启动任何对话时使用 - 确定如何查找和使用技能，在进行任何回复（包括澄清问题）之前，都必须调用 Skill 工具"
   ```
3. **`skills/xiaoming-brainstorming-dispatching-parallel-agents/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "当面临两个或以上可在没有共享状态或顺序依赖关系的情况下独立进行的任务时使用"
   ```
4. **`skills/xiaoming-brainstorming-executing-plans/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "当您有已编写的实施计划且需要在带有评审检查点的单独会话中执行时使用"
   ```
5. **`skills/xiaoming-brainstorming-finishing-a-development-branch/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "当实施完成、所有测试通过，并且您需要决定如何集成工作时使用 - 通过提供合并、PR 或清理等结构化选项来指导完成开发工作"
   ```
6. **`skills/xiaoming-brainstorming-receiving-code-review/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "在收到代码审查反馈并准备实施建议前使用，特别是如果反馈不明确或在技术上令人存疑 - 这需要技术严谨性和验证，而不是形式上的同意或盲目执行"
   ```
7. **`skills/xiaoming-brainstorming-requesting-code-review/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "在完成任务、实现主要特性或在合并前使用，以验证工作是否符合要求"
   ```
8. **`skills/xiaoming-brainstorming-subagent-driven-development/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "在当前会话中执行包含独立任务的实施计划时使用"
   ```
9. **`skills/xiaoming-brainstorming-systematic-debugging/SKILL.md`**:
   Replace line 3:
   ```yaml
   description: "在遇到任何 Bug、测试失败或非预期行为时，且在提出修复方案之前使用"
   ```
10. **`skills/xiaoming-brainstorming-test-driven-development/SKILL.md`**:
    Replace line 3:
    ```yaml
    description: "在实现任何特性或修复 Bug 时，且在编写任何业务代码前使用"
    ```
11. **`skills/xiaoming-brainstorming-using-git-worktrees/SKILL.md`**:
    Replace line 3:
    ```yaml
    description: "在启动需要与当前工作区隔离的特性工作时，或在执行实施计划之前使用 - 通过原生工具或 git worktree 回退方案确保隔离的工作区存在"
    ```
12. **`skills/xiaoming-brainstorming-verification-before-completion/SKILL.md`**:
    Replace line 3:
    ```yaml
    description: "在声称工作已完成、已修复或已通过之前，以及在提交或创建 PR 前使用 - 要求在做出任何成功声明前运行验证命令并确认输出；凡事讲求证据，严禁空口凭断"
    ```
13. **`skills/xiaoming-brainstorming-writing-plans/SKILL.md`**:
    Replace line 3:
    ```yaml
    description: "当您有针对多步骤任务的规范或需求时，在接触代码之前使用"
    ```
14. **`skills/xiaoming-brainstorming-writing-skills/SKILL.md`**:
    Replace line 3:
    ```yaml
    description: "在创建新技能、编辑现有技能或在部署前验证技能正常工作时使用"
    ```

- [ ] **Step 2: Verify translations in frontmatter**

Run:
```bash
git diff skills/*/SKILL.md
```
Expected: YAML description fields are in Chinese.

- [ ] **Step 3: Commit**

Run:
```bash
git commit -am "feat: translate skill metadata descriptions to Chinese"
```

---

### Task 6: Custom Verification Script and Final Handoff

**Files:**
- Create: `scripts/verify-xiaoming.sh`

- [ ] **Step 1: Create verification script**

Create `scripts/verify-xiaoming.sh` to validate the rebranding state:
```bash
#!/usr/bin/env bash
# Verification script for Xiaoming rebranding.
set -euo pipefail

echo "=== Verification Script for Xiaoming Rebranding ==="

errors=0

# 1. Check directories
check_dir() {
    if [ ! -d "$1" ]; then
        echo "❌ Directory missing: $1"
        errors=$((errors+1))
    else
        echo "✅ Directory exists: $1"
    fi
}
check_dir "skills/xiaoming-brainstorming"
check_dir "skills/xiaoming-brainstorming-using-xiaoming"
check_dir "docs/xiaoming"

# 2. Check manifests JSON validity and keys
check_manifest() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "❌ Manifest missing: $file"
        errors=$((errors+1))
        return
    fi
    local name
    name=$(jq -r '.name' "$file")
    if [ "$name" != "xiaoming" ]; then
        echo "❌ Manifest $file 'name' key is '$name', expected 'xiaoming'"
        errors=$((errors+1))
    else
        echo "✅ Manifest $file 'name' key matches 'xiaoming'"
    fi
}
check_manifest ".cursor-plugin/plugin.json"
check_manifest ".claude-plugin/plugin.json"
check_manifest ".codex-plugin/plugin.json"
check_manifest "gemini-extension.json"

# 3. Check for dangling xiaoming namespaces in skills and docs
dangling_ns=$(grep -rn "xiaoming:" skills/ docs/ || true)
if [ -n "$dangling_ns" ]; then
    echo "❌ Dangling 'xiaoming:' namespace references found:"
    echo "$dangling_ns"
    errors=$((errors+1))
else
    echo "✅ No dangling 'xiaoming:' namespace references found."
fi

# 4. Check for old brainstorming namespace references
dangling_brainstorming=$(grep -rn "xiaoming:xiaoming-brainstorming" skills/ docs/ || true)
if [ -n "$dangling_brainstorming" ]; then
    echo "❌ Dangling 'xiaoming:xiaoming-brainstorming' references found (should be 'xiaoming:xiaoming-brainstorming'):"
    echo "$dangling_brainstorming"
    errors=$((errors+1))
else
    echo "✅ No dangling 'xiaoming:xiaoming-brainstorming' references found."
fi

# Summary
if [ "$errors" -eq 0 ]; then
    echo "🎉 Verification passed! Rebranding to Xiaoming is successful."
    exit 0
else
    echo "❌ Verification failed with $errors errors."
    exit 1
fi
```

- [ ] **Step 2: Run verification script**

Run:
```bash
chmod +x scripts/verify-xiaoming.sh
./scripts/verify-xiaoming.sh
```
Expected: Script runs and prints success status.

- [ ] **Step 3: Commit**

Run:
```bash
git add scripts/verify-xiaoming.sh
git commit -m "test: add verification script for rebranding validation"
```
