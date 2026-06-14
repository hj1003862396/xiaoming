# 可视化伴侣 (Visual Companion) 使用指南

基于浏览器的可视化头脑风暴 (brainstorming) 伴侣，用于展示原型图、图表和选项。

## 使用时机

逐问决策，而非逐会话决策。判断标准：**用户看到比阅读更容易理解吗？**

**使用浏览器**，当内容本身具有视觉性时：

- **UI 原型图** — 线框图、布局、导航结构、组件设计
- **架构图** — 系统组件、数据流、关系图
- **并排视觉对比** — 比较两种布局、两种配色方案、两种设计方向
- **设计细节** — 当问题涉及外观与感觉、间距、视觉层次时
- **空间关系** — 状态机、流程图、实体关系渲染为图表

**使用终端**，当内容为文字或表格时：

- **需求与范围问题** — "X 是什么意思？"、"哪些功能在范围内？"
- **概念性 A/B/C 选择** — 在文字描述的方案之间选择
- **权衡 (trade-off) 列表** — 优缺点、对比表格
- **技术决策** — API 设计、数据建模、架构方案选择
- **澄清问题** — 任何答案是文字而非视觉偏好的问题

*关于* UI 话题的问题并不自动成为视觉问题。"你想要什么样的向导？"是概念性问题——用终端。"哪种向导布局感觉更合适？"是视觉问题——用浏览器。

## 工作原理

服务器监视一个目录中的 HTML 文件并将最新的一个提供给浏览器。你将 HTML 内容写入 `screen_dir`，用户在浏览器中看到它并可点击选择选项。选择结果记录到 `state_dir/events` 中，你在下一轮时读取。

**内容片段 vs 完整文档：** 如果你的 HTML 文件以 `<!DOCTYPE` 或 `<html` 开头，服务器会原样提供（仅注入辅助脚本）。否则，服务器会自动将你的内容包裹在框架模板中——添加页眉、CSS 主题、选择指示器和所有交互基础设施。**默认情况下写内容片段。** 只有当你需要完全控制页面时才写完整文档。

## 启动会话

```bash
# 启动服务器并持久化（原型图保存到项目）
scripts/start-server.sh --project-dir /path/to/project

# 返回：{"type":"server-started","port":52341,"url":"http://localhost:52341",
#        "screen_dir":"/path/to/project/.xiaoming/brainstorm/12345-1706000000/content",
#        "state_dir":"/path/to/project/.xiaoming/brainstorm/12345-1706000000/state"}
```

保存响应中的 `screen_dir` 和 `state_dir`。告诉用户打开该 URL。

**查找连接信息：** 服务器将启动 JSON 写入 `$STATE_DIR/server-info`。如果你在后台启动了服务器且未捕获 stdout，读取该文件以获取 URL 和端口。使用 `--project-dir` 时，检查 `<project>/.xiaoming/brainstorm/` 下的会话目录。

**注意：** 传入项目根目录作为 `--project-dir`，这样原型图会持久化在 `.xiaoming/brainstorm/` 中并在服务器重启后仍然存在。不传此参数则文件会进入 `/tmp` 并被清理。提醒用户将 `.xiaoming/` 添加到 `.gitignore`（如果尚未添加）。

**按平台启动服务器：**

**Claude Code（macOS / Linux）：**
```bash
# 默认模式可用——脚本自身会将服务器后台运行
scripts/start-server.sh --project-dir /path/to/project
```

**Claude Code（Windows）：**
```bash
# Windows 自动检测并使用前台模式，这会阻塞工具调用。
# 在 Bash 工具调用上设置 run_in_background: true，使服务器在对话轮次间存活
scripts/start-server.sh --project-dir /path/to/project
```
通过 Bash 工具调用此命令时，设置 `run_in_background: true`。然后在下一轮读取 `$STATE_DIR/server-info` 以获取 URL 和端口。

**Codex：**
```bash
# Codex 会回收后台进程。脚本自动检测 CODEX_CI 并切换到前台模式。正常运行即可——无需额外标志。
scripts/start-server.sh --project-dir /path/to/project
```

**Gemini CLI：**
```bash
# 使用 --foreground 并在 shell 工具调用上设置 is_background: true
# 使进程在轮次间存活
scripts/start-server.sh --project-dir /path/to/project --foreground
```

**其他环境：** 服务器必须在对话轮次间持续在后台运行。如果你的环境会回收分离的进程，使用 `--foreground` 并通过平台的后台执行机制启动命令。

如果 URL 无法从你的浏览器访问（在远程/容器化环境中常见），绑定非回环主机：

```bash
scripts/start-server.sh \
  --project-dir /path/to/project \
  --host 0.0.0.0 \
  --url-host localhost
```

使用 `--url-host` 控制返回的 URL JSON 中显示的主机名。

## 工作循环

1. **检查服务器是否存活**，然后**将 HTML 写入** `screen_dir` 中的新文件：
   - 每次写入前，检查 `$STATE_DIR/server-info` 是否存在。如果不存在（或 `$STATE_DIR/server-stopped` 存在），服务器已关闭——继续之前用 `start-server.sh` 重启它。服务器在无活动 30 分钟后自动退出。
   - 使用语义化文件名：`platform.html`、`visual-style.html`、`layout.html`
   - **永远不要重用文件名** — 每个屏幕使用新文件
   - 使用 Write 工具 — **永远不要使用 cat/heredoc**（会在终端产生噪音）
   - 服务器自动提供最新的文件

2. **告知用户预期内容并结束你的轮次：**
   - 提醒他们 URL（每步都提醒，不只是第一次）
   - 简短文字说明屏幕上的内容（例如"展示首页的 3 种布局选项"）
   - 请他们在终端回复："看一下，告诉我你的想法。如果你想选择某个选项，请点击。"

3. **下一轮** — 用户在终端回复后：
   - 如果 `$STATE_DIR/events` 存在，读取它 — 包含用户的浏览器交互（点击、选择），格式为 JSON 行
   - 与用户的终端文字合并，获取完整信息
   - 终端消息是主要反馈；`state_dir/events` 提供结构化交互数据

4. **迭代或推进** — 如果反馈改变了当前屏幕，写一个新文件（例如 `layout-v2.html`）。只有在当前步骤得到验证后才进入下一个问题。

5. **返回终端时卸载** — 当下一步不需要浏览器时（例如澄清问题、权衡讨论），推送一个等待屏幕以清除过时内容：

   ```html
   <!-- filename: waiting.html (or waiting-2.html, etc.) -->
   <div style="display:flex;align-items:center;justify-content:center;min-height:60vh">
     <p class="subtitle">继续在终端中进行...</p>
   </div>
   ```

   这防止用户在对话已经推进后还盯着一个已解决的选择。当下一个视觉问题出现时，像往常一样推送新的内容文件。

6. 重复直到完成。

## 编写内容片段

只写放在页面内部的内容。服务器会自动用框架模板包裹它（页眉、主题 CSS、选择指示器和所有交互基础设施）。

**最简示例：**

```html
<h2>哪种布局效果更好？</h2>
<p class="subtitle">考虑可读性和视觉层次</p>

<div class="options">
  <div class="option" data-choice="a" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>单列</h3>
      <p>简洁、专注的阅读体验</p>
    </div>
  </div>
  <div class="option" data-choice="b" onclick="toggleSelect(this)">
    <div class="letter">B</div>
    <div class="content">
      <h3>双列</h3>
      <p>带侧边栏导航的主内容区</p>
    </div>
  </div>
</div>
```

就这些。不需要 `<html>`、CSS 或 `<script>` 标签。服务器提供所有这些。

## 可用的 CSS 类

框架模板为你的内容提供以下 CSS 类：

### 选项（A/B/C 选择）

```html
<div class="options">
  <div class="option" data-choice="a" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>标题</h3>
      <p>描述</p>
    </div>
  </div>
</div>
```

**多选：** 在容器上添加 `data-multiselect` 以允许用户选择多个选项。每次点击切换该项目。指示器栏显示数量。

```html
<div class="options" data-multiselect>
  <!-- 相同的选项标记 — 用户可以选择/取消选择多个 -->
</div>
```

### 卡片（视觉设计）

```html
<div class="cards">
  <div class="card" data-choice="design1" onclick="toggleSelect(this)">
    <div class="card-image"><!-- 原型图内容 --></div>
    <div class="card-body">
      <h3>名称</h3>
      <p>描述</p>
    </div>
  </div>
</div>
```

### 原型图容器

```html
<div class="mockup">
  <div class="mockup-header">预览：仪表板布局</div>
  <div class="mockup-body"><!-- 你的原型图 HTML --></div>
</div>
```

### 分割视图（并排）

```html
<div class="split">
  <div class="mockup"><!-- 左侧 --></div>
  <div class="mockup"><!-- 右侧 --></div>
</div>
```

### 优缺点

```html
<div class="pros-cons">
  <div class="pros"><h4>优点</h4><ul><li>优势</li></ul></div>
  <div class="cons"><h4>缺点</h4><ul><li>不足</li></ul></div>
</div>
```

### 模拟元素（线框构建块）

```html
<div class="mock-nav">Logo | 首页 | 关于 | 联系</div>
<div style="display: flex;">
  <div class="mock-sidebar">导航</div>
  <div class="mock-content">主内容区</div>
</div>
<button class="mock-button">操作按钮</button>
<input class="mock-input" placeholder="输入框">
<div class="placeholder">占位区域</div>
```

### 排版与章节

- `h2` — 页面标题
- `h3` — 章节标题
- `.subtitle` — 标题下方的次要文字
- `.section` — 带底部间距的内容块
- `.label` — 小型大写标签文字

## 浏览器事件格式

当用户在浏览器中点击选项时，他们的交互会记录到 `$STATE_DIR/events`（每行一个 JSON 对象）。推送新屏幕时文件会自动清空。

```jsonl
{"type":"click","choice":"a","text":"选项 A - 简单布局","timestamp":1706000101}
{"type":"click","choice":"c","text":"选项 C - 复杂网格","timestamp":1706000108}
{"type":"click","choice":"b","text":"选项 B - 混合方式","timestamp":1706000115}
```

完整的事件流展示了用户的探索路径——他们可能在确定前点击多个选项。最后的 `choice` 事件通常是最终选择，但点击模式可以揭示值得进一步询问的犹豫或偏好。

如果 `$STATE_DIR/events` 不存在，用户没有与浏览器交互——仅使用他们的终端文字。

## 设计技巧

- **根据问题调整保真度** — 布局问题用线框图，细节问题用精细设计
- **在每个页面解释问题** — "哪种布局感觉更专业？"而不只是"选一个"
- **推进前先迭代** — 如果反馈改变了当前屏幕，写一个新版本
- **每屏最多 2-4 个选项**
- **必要时使用真实内容** — 对于摄影作品集，使用真实图片（Unsplash）。占位内容会掩盖设计问题。
- **保持原型图简洁** — 专注于布局和结构，而非像素级完美设计

## 文件命名

- 使用语义化名称：`platform.html`、`visual-style.html`、`layout.html`
- 永远不要重用文件名——每个屏幕必须是新文件
- 迭代版本：附加版本后缀，如 `layout-v2.html`、`layout-v3.html`
- 服务器按修改时间提供最新的文件

## 清理

```bash
scripts/stop-server.sh $SESSION_DIR
```

如果会话使用了 `--project-dir`，原型图文件会持久化在 `.xiaoming/brainstorm/` 中以供后续参考。只有 `/tmp` 会话在停止时被删除。

## 参考

- 框架模板（CSS 参考）：`scripts/frame-template.html`
- 辅助脚本（客户端）：`scripts/helper.js`
