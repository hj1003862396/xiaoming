# 设计规约：在 README.md 中添加 Antigravity 安装与测试指南

本设计规约详述了在 `README.md` 中为 **Antigravity (Gemini)** 平台添加本地同步、安装、更新、验证和验收文档的修改方案。

---

## 修改范围与目标

1. **更新 README.md**：
   - 保留现有的 `## 安装指南 (Cursor)` 段落。
   - 新增 `## 安装指南 (Antigravity)` 二级标题段落，描述针对 Antigravity 平台的本地同步脚本调用、启用说明、更新命令、验证脚本调用，以及验收方式。
   - 两个平台的安装指南段落并行，内容互不干扰，格式对齐。

---

## 详细变更方案

### 1. 修改 [README.md](file:///Users/hanjie/IdeaProjects/xiaoming/README.md)

* **修改内容**：
  在 `## 安装指南 (Cursor)` 的验收小节下方，添加全新的 `## 安装指南 (Antigravity)` 段落。

* **具体修改设计**：
  ```markdown
  ## 安装指南 (Antigravity)

  ```bash
  # 克隆后安装
  git clone https://github.com/hj1003862396/xiaoming.git
  cd xiaoming
  ./scripts/sync-to-antigravity-local.sh
  ```

  ```text
  # 启用插件
  Antigravity 会在启动时自动从 ~/.gemini/config/plugins/ 加载插件，无需手动配置。
  ```

  ```bash
  # 更新
  ./scripts/sync-to-antigravity-local.sh
  ```

  ```bash
  # 验证
  ./scripts/verify-xiaoming.sh
  ```

  ```text
  # 验收
  /xiaoming-brainstorming 你好
  ```
  ```

---

## 验证与验收标准

1. **本地验证脚本**：
   - 运行 `./scripts/verify-xiaoming.sh`，确保该验证脚本正常通过，且同步脚本状态一切正常。
2. **文档内容和链接检查**：
   - 确认 `README.md` 中新加的 `## 安装指南 (Antigravity)` 部分格式正确、代码块高亮无语法错误、内容描述准确无误。
3. **命令验收**：
   - 触发 `/xiaoming-brainstorming` 命令以确保在 Antigravity 环境下能拉起头脑风暴技能。
