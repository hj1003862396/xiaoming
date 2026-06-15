# Antigravity 本地同步与元数据配置 实施计划

> **对于代理工作者：** 必须使用子技能：使用 xiaoming:xiaoming-brainstorming-subagent-driven-development（推荐）或 xiaoming:xiaoming-brainstorming-executing-plans 逐任务实施此计划。步骤使用复选框（`- [ ]`）语法进行追踪。

**目标：** 在仓库中添加特定于 Antigravity (Gemini) 平台的插件元数据配置，并编写本地同步脚本以支持本地插件开发调试，同时与版本管理审计集成。

**架构：** 
1. 新建 `.antigravity-plugin` 目录放置 `plugin.json` 和 `installed_version.json` 模板文件（版本设为 `1.0.0`）。
2. 在 `scripts/sync-to-antigravity-local.sh` 中实现 rsync 核心代码及拷贝上述两个元数据文件至目标目录 `~/.gemini/config/plugins/xiaoming` 的逻辑。
3. 修改 `.version-bump.json`，在 `audit.exclude` 中排除 `.antigravity-plugin`，以允许其保持 `1.0.0` 独立版本。
4. 修改 `scripts/verify-xiaoming.sh`，添加对 `sync-to-antigravity-local.sh` 存在性及可执行状态的校验。

**技术栈：** Bash, jq, rsync

---

### Task 1：创建 Antigravity 插件配置目录及元数据文件

**文件：**
- 创建：`.antigravity-plugin/plugin.json`
- 创建：`.antigravity-plugin/installed_version.json`

- [ ] **步骤 1：创建并配置 `.antigravity-plugin/plugin.json`**
  写最少实施代码：新建 `.antigravity-plugin/plugin.json` 并填入以下内容：
  ```json
  {
    "name": "xiaoming",
    "version": "1.0.0",
    "description": "Core skills library: TDD, debugging, collaboration patterns, and proven techniques",
    "author": {
      "name": "hanjie",
      "email": "hanjievvvp@163.com"
    },
    "homepage": "https://github.com/hj1003862396/xiaoming",
    "repository": "https://github.com/hj1003862396/xiaoming",
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

- [ ] **步骤 2：创建并配置 `.antigravity-plugin/installed_version.json`**
  写最少实施代码：新建 `.antigravity-plugin/installed_version.json` 并填入以下内容：
  ```json
  {"version": "1.0.0"}
  ```

- [ ] **步骤 3：验证元数据文件格式**
  运行：`jq . .antigravity-plugin/plugin.json && jq . .antigravity-plugin/installed_version.json`
  预期：输出正确的 JSON 格式内容，无语法错误。

- [ ] **步骤 4：提交 (commit)**
  运行：
  ```bash
  git add .antigravity-plugin/plugin.json .antigravity-plugin/installed_version.json
  git commit -m "feat: add antigravity plugin manifests"
  ```

---

### Task 2：更新版本管理配置

**文件：**
- 修改：`.version-bump.json`

- [ ] **步骤 1：在 `.version-bump.json` 中配置 audit.exclude**
  写最少实施代码：编辑 `.version-bump.json`，在 `audit.exclude` 列表中添加 `".antigravity-plugin"`。
  ```json
    "audit": {
      "exclude": [
        "CHANGELOG.md",
        "RELEASE-NOTES.md",
        "node_modules",
        ".git",
        ".antigravity-plugin",
        ".version-bump.json",
        "scripts/bump-version.sh"
      ]
    }
  ```

- [ ] **步骤 2：验证版本检查脚本没有报错**
  运行：`./scripts/bump-version.sh --check`
  预期：输出正常检查结果，无漂移报错，亦无因新增目录导致的 audit 报警。

- [ ] **步骤 3：提交 (commit)**
  运行：
  ```bash
  git add .version-bump.json
  git commit -m "chore: exclude .antigravity-plugin from version-bump audit"
  ```

---

### Task 3：编写本地同步脚本

**文件：**
- 创建：`scripts/sync-to-antigravity-local.sh`

- [ ] **步骤 1：创建并配置同步脚本**
  写最少实施代码：新建 `scripts/sync-to-antigravity-local.sh`，并填入以下内容：
  ```bash
  #!/usr/bin/env bash
  # Copy this checkout into ~/.gemini/config/plugins/xiaoming for Antigravity local testing.
  #
  # Usage:
  #   ./scripts/sync-to-antigravity-local.sh

  set -euo pipefail

  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
  DEST="${HOME}/.gemini/config/plugins/xiaoming"

  mkdir -p "${HOME}/.gemini/config/plugins"

  if [ -L "${DEST}" ] || [ -d "${DEST}" ]; then
    rm -rf "${DEST}"
  fi

  # 1. Sync the core plugin content
  rsync -a --delete \
    --exclude='.git/' \
    --exclude='.idea/' \
    --exclude='node_modules/' \
    --exclude='tests/brainstorm-server/node_modules/' \
    "${PLUGIN_ROOT}/" "${DEST}/"

  # 2. Copy the plugin metadata files to the destination root folder
  cp "${PLUGIN_ROOT}/.antigravity-plugin/plugin.json" "${DEST}/plugin.json"
  cp "${PLUGIN_ROOT}/.antigravity-plugin/installed_version.json" "${DEST}/installed_version.json"

  echo "Synced xiaoming to ${DEST}"
  ```

- [ ] **步骤 2：使脚本可执行**
  运行：`chmod +x scripts/sync-to-antigravity-local.sh`
  预期：无报错。

- [ ] **步骤 3：测试同步脚本的运行**
  运行：`./scripts/sync-to-antigravity-local.sh`
  预期：
  1. 输出 `Synced xiaoming to /Users/hanjie/.gemini/config/plugins/xiaoming`。
  2. 运行 `ls -F ~/.gemini/config/plugins/xiaoming` 确认包含 `skills/`、`plugin.json`、`installed_version.json` 等。
  3. 运行 `cat ~/.gemini/config/plugins/xiaoming/plugin.json` 确认版本号为 `1.0.0`。

- [ ] **步骤 4：提交 (commit)**
  运行：
  ```bash
  git add scripts/sync-to-antigravity-local.sh
  git commit -m "feat: add local sync script for antigravity plugin"
  ```

---

### Task 4：更新全局验证脚本

**文件：**
- 修改：`scripts/verify-xiaoming.sh`

- [ ] **步骤 1：添加对 Antigravity 同步脚本的验证项**
  写最少实施代码：在 `scripts/verify-xiaoming.sh` 第 51-57 行后，新增对 `scripts/sync-to-antigravity-local.sh` 的验证：
  ```bash
  if [ -f "scripts/sync-to-antigravity-local.sh" ] && [ -x "scripts/sync-to-antigravity-local.sh" ]; then
      echo "✅ Antigravity local sync script exists and is executable"
  else
      echo "❌ Missing or non-executable scripts/sync-to-antigravity-local.sh"
      errors=$((errors+1))
  fi
  ```

- [ ] **步骤 2：运行全局验证脚本验证一切正常**
  运行：`./scripts/verify-xiaoming.sh`
  预期：输出 `🎉 Verification passed! Rebranding to Xiaoming is successful.`，且返回值（Exit Code）为 0。

- [ ] **步骤 3：提交 (commit)**
  运行：
  ```bash
  git add scripts/verify-xiaoming.sh
  git commit -m "chore: add antigravity sync script validation to verify-xiaoming.sh"
  ```
