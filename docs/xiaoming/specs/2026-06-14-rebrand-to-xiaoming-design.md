# 设计规约：将项目全面重构并品牌化为 Xiaoming (小明)

本设计规约详述了将 **Xiaoming** 项目彻底重命名为 **Xiaoming (小明)** 的方案。
我们不仅修改平台清单配置，还将汉化核心技能的描述，并将 `/xiaoming` 斜杠命令直接绑定到原头脑风暴（`brainstorming`）流程中。

---

## 修改范围与目标

1. **核心配置汉化与重命名**：更新所有 IDE/平台的插件清单，将名称改为 `xiaoming`，并将相关描述汉化。
2. **命令绑定 `/xiaoming`**：将 `skills/brainstorming/` 目录重命名为 `skills/xiaoming-brainstorming/`，以实现用户输入 `/xiaoming` 时直接触发设计风暴。
3. **静默引导技能重构**：将原本用于引导初始化的 `xiaoming-using-xiaoming` 技能重构为 `xiaoming-using-xiaoming`。
4. **命名空间与引用替换**：将所有技能调用前缀从 `xiaoming:` 替换为 `xiaoming:`。
5. **物理目录与路径调整**：将 `docs/xiaoming/` 重命名为 `docs/xiaoming/`，并调整所有的内部引用（包括 `GEMINI.md`）。
6. **技能描述汉化**：将所有 `SKILL.md` 文件头部的 `description` 字段翻译为中文，确保 AI 的匹配和触发更符合中文使用习惯。

---

## 详细变更方案

### 1. 清单文件（Manifests）更新

#### `.cursor-plugin/plugin.json`
* **名称与显示名**：将 `"name": "xiaoming"` $\rightarrow$ `"xiaoming"`，`"displayName": "Xiaoming"` $\rightarrow$ `"Xiaoming"`。
* **描述汉化**：将描述改为 `"核心技能库：测试驱动开发、系统调试、协作模式与最佳实践流程"`。
* **引导路径**：将 `"hooks": "./hooks/hooks-cursor.json"` 保持不变，但其调用的初始化技能路径随之更新。

#### `.claude-plugin/plugin.json`
* **名称**：`"name": "xiaoming"`。
* **描述汉化**：将描述改为 `"小明（Xiaoming）核心技能库：测试驱动开发、系统调试、协作模式与最佳实践"`。

#### `.codex-plugin/plugin.json`
* 将主名称修改为 `"xiaoming"`。
* 汉化 `interface` 属性中的 `displayName` (`"小明 (Xiaoming)"`)、`shortDescription` 以及 `longDescription`。

#### `gemini-extension.json`
* `"name": "xiaoming"`
* 描述汉化为 `"小明核心技能库：测试驱动开发、系统调试、协作模式与最佳实践"`。

---

### 2. 目录重命名与结构调整

在文件系统中进行以下移动和更名：
1. **技能目录重命名**：
   * `skills/brainstorming/` $\rightarrow$ `skills/xiaoming-brainstorming/` (注册 `/xiaoming` 命令)
   * `skills/xiaoming-brainstorming-using-xiaoming/` $\rightarrow$ `skills/xiaoming-brainstorming-using-xiaoming/` (静默引导)
2. **文档目录重命名**：
   * `docs/xiaoming/` $\rightarrow$ `docs/xiaoming/`
3. **GEMINI.md 更新**：
   * 指向 `@./skills/xiaoming-brainstorming-using-xiaoming/SKILL.md` 和相应工具文档。

---

### 3. 技能描述（SKILL.md Frontmatter）汉化列表

修改 `skills/` 下所有 `SKILL.md` 顶部的 `description` 字段为中文：

* **`skills/xiaoming-brainstorming/SKILL.md`** (原 brainstorming):
  `description: "在进行任何创造性工作（如创建特性、构建组件、添加功能或修改行为）之前，您必须使用此技能。在实施前探索用户意图、需求和设计。"`
* **`skills/xiaoming-brainstorming-using-xiaoming/SKILL.md`** (原 xiaoming-using-xiaoming):
  `description: "在启动任何对话时使用 - 确定如何查找和使用技能，在进行任何回复（包括澄清问题）之前，都必须调用 Skill 工具"`
* **`skills/xiaoming-brainstorming-test-driven-development/SKILL.md`**:
  `description: "在实现任何特性或修复 Bug 时，且在编写任何业务代码前使用"`
* **`skills/xiaoming-brainstorming-systematic-debugging/SKILL.md`**:
  `description: "在遇到任何 Bug、测试失败或非预期行为时，且在提出修复方案之前使用"`
* **`skills/xiaoming-brainstorming-writing-plans/SKILL.md`**:
  `description: "当您有针对多步骤任务的规范或需求时，在接触代码之前使用"`
* **`skills/xiaoming-brainstorming-verification-before-completion/SKILL.md`**:
  `description: "在声称工作已完成、已修复或已通过之前，以及在提交或创建 PR 前使用 - 要求在做出任何成功声明前运行验证命令并确认输出；凡事讲求证据，严禁空口凭断"`
* 其他技能（包括 `executing-plans`、`dispatching-parallel-agents`、`using-git-worktrees` 等）统一翻译为前文确定的对应中文描述。

---

### 4. 命名空间与全局引用替换

* **前缀替换**：全局搜索所有 `SKILL.md` 及文档中的 `xiaoming:` 替换为 `xiaoming:`。
* **特定替换**：
  * 将对 `xiaoming:xiaoming-brainstorming` 的调用均改为 `xiaoming:xiaoming-brainstorming`。
  * 将对 `xiaoming:xiaoming-brainstorming-using-xiaoming` 的调用均改为 `xiaoming:xiaoming-brainstorming-using-xiaoming`。
  * 所有设计文档和计划文档的存放与生成路径由 `docs/xiaoming/specs/` 和 `docs/xiaoming/plans/` 更新为 `docs/xiaoming/specs/` 和 `docs/xiaoming/plans/`。

---

### 5. 启动钩子脚本（Hooks）汉化与重构

修改 `hooks/session-start` 脚本中的变量定义，完全汉化输出给 AI 代理的 context 内容：
* 提示语汉化：“你已拥有小明（xiaoming）的技能加持...”
* 调用指令汉化：“以下是你的 'xiaoming:xiaoming-brainstorming-using-xiaoming' 技能的完整内容...”
* 警告语汉化：“警告：Xiaoming 现已使用 Claude Code 的技能系统...”

---

## 验证与验收标准

1. **结构验证**：确认 `skills/xiaoming-brainstorming` 和 `skills/xiaoming-brainstorming-using-xiaoming` 目录存在，物理目录 `docs/xiaoming/` 正常迁移。
2. **触发验证**：在 Cursor 插件加载后，测试输入 `/xiaoming` 能够正常拉起设计风暴对话。
3. **初始化验证**：开启新会话时，确保 Hook 能正常加载且注入的 `additional_context` 包含正确的中文提示语和 `xiaoming-using-xiaoming` 内容。
