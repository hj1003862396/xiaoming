# 设计规约：为 Antigravity 平台提供本地插件同步脚本与元数据配置

本设计规约详述了为 **Antigravity (Gemini)** 平台集成本地开发调试支持的方案。
我们将添加特定于该平台的元数据配置，并提供与现有平台对齐的本地同步脚本 `sync-to-antigravity-local.sh`。

---

## 修改范围与目标

1. **新建 Antigravity 插件配置目录**：在仓库根目录新建 `.antigravity-plugin/` 目录，存放平台的声明元数据文件。
2. **存放元数据文件**：在 `.antigravity-plugin/` 下放置 `plugin.json` 和 `installed_version.json`，并将初始版本号设为 `1.0.0`。
3. **添加本地同步脚本**：在 `scripts/` 目录下新建 `sync-to-antigravity-local.sh` 脚本，用于同步代码至 Antigravity 插件目录 `~/.gemini/config/plugins/xiaoming`。
4. **排除版本联动审计**：更新 `.version-bump.json`，在 `audit.exclude` 中排除 `.antigravity-plugin` 目录，防止版本号不一致导致 `bump-version.sh --check` 失败。

---

## 详细变更方案

### 1. 新增清单与元数据文件

#### [plugin.json](file:///Users/hanjie/IdeaProjects/xiaoming/.antigravity-plugin/plugin.json)
* **路径**：新建 `.antigravity-plugin/plugin.json`
* **内容**：
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

#### [installed_version.json](file:///Users/hanjie/IdeaProjects/xiaoming/.antigravity-plugin/installed_version.json)
* **路径**：新建 `.antigravity-plugin/installed_version.json`
* **内容**：
```json
{"version": "1.0.0"}
```

---

### 2. 新增本地同步脚本

#### [sync-to-antigravity-local.sh](file:///Users/hanjie/IdeaProjects/xiaoming/scripts/sync-to-antigravity-local.sh)
* **路径**：新建 `scripts/sync-to-antigravity-local.sh`
* **内容**：
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

---

### 3. 版本管理工具更新

#### [version-bump.json](file:///Users/hanjie/IdeaProjects/xiaoming/.version-bump.json)
* **路径**：修改 `.version-bump.json`
* **改动**：在 `audit.exclude` 数组中添加 `".antigravity-plugin"`，防止 audit 工具因 `.antigravity-plugin/plugin.json` 中的 `1.0.0` 与主版本不一致而报错。
* **差异展示**：
```diff
   "audit": {
     "exclude": [
       "CHANGELOG.md",
       "RELEASE-NOTES.md",
       "node_modules",
       ".git",
+      ".antigravity-plugin",
       ".version-bump.json",
       "scripts/bump-version.sh"
     ]
   }
```

---

## 验证与验收标准

1. **结构验证**：
   - 确认 `.antigravity-plugin/plugin.json` 和 `.antigravity-plugin/installed_version.json` 正确创建并写入。
   - 确认 `scripts/sync-to-antigravity-local.sh` 脚本正确创建。
2. **本地同步功能验证**：
   - 运行 `./scripts/sync-to-antigravity-local.sh`，确认没有报错。
   - 检查 `~/.gemini/config/plugins/xiaoming/` 目录：
     - 是否包含 `skills/`、`scripts/` 等所有仓库代码。
     - 是否在根目录下存在 `plugin.json` 和 `installed_version.json`，且版本号为 `1.0.0`。
3. **版本审计测试**：
   - 运行 `./scripts/bump-version.sh --check` 和 `./scripts/bump-version.sh --audit`。
   - 确认输出没有检测到版本漂移（drift）且没有 undeclared files 警告。
