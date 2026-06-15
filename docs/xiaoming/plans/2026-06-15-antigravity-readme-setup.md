# 在 README.md 中添加 Antigravity 安装与测试指南 实施计划

> **对于代理工作者：** 必须使用子技能：使用 xiaoming:xiaoming-brainstorming-subagent-driven-development（推荐）或 xiaoming:xiaoming-brainstorming-executing-plans 逐任务实施此计划。步骤使用复选框（`- [ ]`）语法进行追踪。

**目标：** 在 README.md 中新增 Antigravity 平台的安装指南（包含克隆安装、启用、更新、验证和验收步骤），保持其与 Cursor 安装指南镜像对齐。

**架构：** 在 `README.md` 的 `安装指南 (Cursor)` 段落后，以二级标题 `## 安装指南 (Antigravity)` 的形式加入全新内容。

**技术栈：** Markdown，Bash 脚本。

---

### Task 1：修改 README.md 添加 Antigravity 平台安装指南

**文件：**
- 修改：`README.md`
- 验证：运行 `scripts/verify-xiaoming.sh`

- [ ] **步骤 1：本地预览和检查当前的 README.md 结构**

  运行：`head -n 40 README.md`
  预期：显示 README.md 前 40 行，包含 `## 安装指南 (Cursor)` 以及后续的各 bash/text 块。

- [ ] **步骤 2：添加 Antigravity 平台安装与测试指南的 Markdown 内容**

  写最少实施代码：在 `README.md` 文件末尾（第 34 行之后）添加以下内容：

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

- [ ] **步骤 3：运行验证脚本确保 rebranding 和配置一切正常**

  运行：`./scripts/verify-xiaoming.sh`
  预期：输出 `🎉 Verification passed! Rebranding to Xiaoming is successful.`，且返回值状态为 0。

- [ ] **步骤 4：提交 (commit)**

  运行：
  ```bash
  git add README.md
  git commit -m "docs: add antigravity installation and setup guide to README"
  ```
  预期：提交成功，git tree 干净。
