# 设计规约：将 Skills 物理路径与元数据名称统一重命名为 `xiaoming-xxx`

本设计规约详述了将 **Xiaoming** 项目中所有 Skill 的物理目录及元数据 `name` 统一加上 `xiaoming-` 前缀（特殊命名的按约定处理）的方案。以使 AI 代理在调用时能采用统一的 `/xiaoming-xxx` 格式。

---

## 修改范围与目标

1. **物理目录与元数据重命名**：将所有 `skills/` 下的子目录均物理重命名为 `xiaoming-xxx` 形式，同步修改其 `SKILL.md` 头部 Frontmatter 中的 `name` 字段。
   - 特殊地：
     - `xiaoming` $\rightarrow$ `xiaoming-brainstorming`
     - `using-xiaoming-bootstrap` $\rightarrow$ `xiaoming-using-xiaoming`
2. **全局引用及命名空间更新**：将所有技能调用前缀及相关文档/脚本中的 `xiaoming:xxx` 统一更新为新的 `xiaoming:xiaoming-xxx`，确保引用链条完整。
3. **加载器与初始化钩子适配**：更新 `hooks/session-start`、`.opencode/plugins/xiaoming.js` 和 `scripts/verify-xiaoming.sh` 中对引导技能和特定目录的读取与验证逻辑。
4. **快捷命令（Slash Command）同步**：将 `/xiaoming` 命令重命名为 `/xiaoming-brainstorming`，修改 `commands/xiaoming.md` $\rightarrow$ `commands/xiaoming-brainstorming.md`。
5. **测试套件同步**：更新 `tests/` 目录下的所有测试脚本、校验用例 and naive 触发/显式调用的 Prompt 文件。

---

## 详细变更方案

### 1. 物理目录与元数据重命名映射列表
所有重命名操作将直接修改本地文件系统目录，不使用 git 命令。

| 原物理目录路径 (在 `skills/` 下) | 新物理目录路径 (在 `skills/` 下) | 原 `name` 字段 | 新 `name` 字段 |
| :--- | :--- | :--- | :--- |
| `xiaoming` | `xiaoming-brainstorming` | `xiaoming` | `xiaoming-brainstorming` |
| `using-xiaoming-bootstrap` | `xiaoming-using-xiaoming` | `using-xiaoming-bootstrap` | `xiaoming-using-xiaoming` |
| `dispatching-parallel-agents` | `xiaoming-dispatching-parallel-agents` | `dispatching-parallel-agents` | `xiaoming-dispatching-parallel-agents` |
| `executing-plans` | `xiaoming-executing-plans` | `executing-plans` | `xiaoming-executing-plans` |
| `finishing-a-development-branch` | `xiaoming-finishing-a-development-branch` | `finishing-a-development-branch` | `xiaoming-finishing-a-development-branch` |
| `receiving-code-review` | `xiaoming-receiving-code-review` | `receiving-code-review` | `xiaoming-receiving-code-review` |
| `requesting-code-review` | `xiaoming-requesting-code-review` | `requesting-code-review` | `xiaoming-requesting-code-review` |
| `subagent-driven-development` | `xiaoming-subagent-driven-development` | `subagent-driven-development` | `xiaoming-subagent-driven-development` |
| `systematic-debugging` | `xiaoming-systematic-debugging` | `systematic-debugging` | `xiaoming-systematic-debugging` |
| `test-driven-development` | `xiaoming-test-driven-development` | `test-driven-development` | `xiaoming-test-driven-development` |
| `using-git-worktrees` | `xiaoming-using-git-worktrees` | `using-git-worktrees` | `xiaoming-using-git-worktrees` |
| `verification-before-completion` | `xiaoming-verification-before-completion` | `verification-before-completion` | `xiaoming-verification-before-completion` |
| `writing-plans` | `xiaoming-writing-plans` | `writing-plans` | `xiaoming-writing-plans` |
| `writing-skills` | `xiaoming-writing-skills` | `writing-skills` | `xiaoming-writing-skills` |

### 2. Slash Command 重命名
* 将 `commands/xiaoming.md` 重命名为 `commands/xiaoming-brainstorming.md`。
* 内部描述和技能调用改为：
  ```markdown
  调用 xiaoming:xiaoming-brainstorming 技能，并严格按照其中给出的指引执行。
  ```

### 3. 加载器与启动钩子更新
* **`hooks/session-start`**：
  * 修改读取引导技能的物理路径：
    `using_superpowers_content=$(cat "${PLUGIN_ROOT}/skills/xiaoming-using-xiaoming/SKILL.md" ...)`
  * 替换 JSON 注入内容中的引导技能文本提示：
    `**以下是你的 'xiaoming:xiaoming-using-xiaoming' 技能的完整内容...**`
* **`.opencode/plugins/xiaoming.js`**：
  * 修改 `getBootstrapContent` 中加载技能路径：
    `const skillPath = path.join(xiaomingSkillsDir, 'xiaoming-using-xiaoming', 'SKILL.md');`
  * 修改判断防重入条件与系统提示文本中对 `using-xiaoming-bootstrap` 的引用为 `xiaoming-using-xiaoming`。
* **`scripts/verify-xiaoming.sh`**：
  * 将 `check_dir "skills/xiaoming"` $\rightarrow$ `check_dir "skills/xiaoming-brainstorming"`。
  * 将 `check_dir "skills/using-xiaoming-bootstrap"` $\rightarrow$ `check_dir "skills/xiaoming-using-xiaoming"`。
  * 将 `check_manifest` 与 `commands/xiaoming.md` 校验路径改为 `commands/xiaoming-brainstorming.md`。

### 4. 全局引用大替换
全局扫描所有 `SKILL.md`（包括新重命名后的物理路径下的文件）、`docs/` 下的 spec/plan 文档、`CLAUDE.md` 及 `README.md`，执行以下文本替换：
* `xiaoming:xiaoming` $\rightarrow$ `xiaoming:xiaoming-brainstorming`
* `xiaoming:using-xiaoming-bootstrap` $\rightarrow$ `xiaoming:xiaoming-using-xiaoming`
* `xiaoming:dispatching-parallel-agents` $\rightarrow$ `xiaoming:xiaoming-dispatching-parallel-agents`
* `xiaoming:executing-plans` $\rightarrow$ `xiaoming:xiaoming-executing-plans`
* `xiaoming:finishing-a-development-branch` $\rightarrow$ `xiaoming:xiaoming-finishing-a-development-branch`
* `xiaoming:receiving-code-review` $\rightarrow$ `xiaoming:xiaoming-receiving-code-review`
* `xiaoming:requesting-code-review` $\rightarrow$ `xiaoming:xiaoming-requesting-code-review`
* `xiaoming:subagent-driven-development` $\rightarrow$ `xiaoming:xiaoming-subagent-driven-development`
* `xiaoming:systematic-debugging` $\rightarrow$ `xiaoming:xiaoming-systematic-debugging`
* `xiaoming:test-driven-development` $\rightarrow$ `xiaoming:xiaoming-test-driven-development`
* `xiaoming:using-git-worktrees` $\rightarrow$ `xiaoming:xiaoming-using-git-worktrees`
* `xiaoming:verification-before-completion` $\rightarrow$ `xiaoming:xiaoming-verification-before-completion`
* `xiaoming:writing-plans` $\rightarrow$ `xiaoming:xiaoming-writing-plans`
* `xiaoming:writing-skills` $\rightarrow$ `xiaoming:xiaoming-writing-skills`

同时检查类似 `skills/using-xiaoming-bootstrap/` 路径形式的字符串，将其转换为 `skills/xiaoming-using-xiaoming/` 形式。

### 5. 测试用例适配与 Prompt 更新
* **`tests/opencode/test-bootstrap-caching.mjs`**：
  * 修改 `isBootstrapSkillPath` 校验：
    `return String(filePath).replaceAll('\\', '/').includes('xiaoming-using-xiaoming/SKILL.md');`
* **`tests/skill-triggering/run-all.sh`**：
  * 更新 `SKILLS` 数组中的成员，将 `systematic-debugging`, `test-driven-development`, `writing-plans`, `dispatching-parallel-agents`, `executing-plans`, `requesting-code-review` 替换为带有 `xiaoming-` 前缀的版本。
* **`tests/explicit-skill-requests/run-all.sh`**：
  * 更新 `run-test.sh` 的调用参数，把原本的 skill name （如 `subagent-driven-development`, `systematic-debugging`, `xiaoming`）更新为对应的带有前缀的名称（`xiaoming-subagent-driven-development`, `xiaoming-systematic-debugging`, `xiaoming-brainstorming`）。
* **`tests/skill-triggering/prompts/`** 与 **`tests/explicit-skill-requests/prompts/`** 目录：
  * 重命名所有文本 Prompt 文件的文件名为带有 `xiaoming-` 前缀（`xiaoming-test-driven-development.txt` 等）。
  * 替换 `please-use-xiaoming.txt` 中的内容 `xiaoming skill` $\rightarrow$ `xiaoming-brainstorming skill`。
  * 替换 `use-systematic-debugging.txt` 中的内容 `systematic-debugging` $\rightarrow$ `xiaoming-systematic-debugging`。

---

## 验证与验收标准

1. **文件目录校验**：运行 `scripts/verify-xiaoming.sh`，确保该脚本校验全部通过，没有残余的老命名配置。
2. **测试用例运行**：
   - 运行 `./tests/skill-triggering/run-all.sh`，确保所有 naive trigger 测试通过。
   - 运行 `./tests/explicit-skill-requests/run-all.sh`，确保所有显式请求测试通过。
3. **IDE 平台加载校验**：确认重新加载后在各平台中可以通过 `/xiaoming-brainstorming` 正确触发头脑风暴，且新加载的上下文没有报错。
