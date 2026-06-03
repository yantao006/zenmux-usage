# zenmux-usage

[English](#english) | [中文](#中文)

---

## English

A macOS menu bar plugin that shows your [ZenMux](https://zenmux.ai) remaining quota (5-hour and 7-day) at a glance.

![preview](https://img.shields.io/badge/xbar-plugin-blue)

```
Menu bar:  Z 615/800
─────────────────────
5h  614.8 / 800  (23.1% used)
7d  1372.0 / 3414  (59.8% used)
─────────────────────
Updated 23:19:33
```

### Requirements

- macOS
- [xbar](https://xbarapp.com) (installed automatically by the installer)
- A ZenMux **Management API Key** — create one at [zenmux.ai](https://zenmux.ai) → Console → Management

### One-line Install

```bash
curl -fsSL https://raw.githubusercontent.com/yantao006/zenmux-usage/main/install.sh | bash
```

The installer will:
1. Install xbar if not present (via Homebrew)
2. Prompt for your Management API Key
3. Store it securely in `~/.config/zenmux/key` (mode 600)
4. Copy the plugin to xbar's plugins directory
5. Launch xbar

### Manual Install

```bash
git clone https://github.com/yantao006/zenmux-usage.git
cd zenmux-usage
bash install.sh
```

### Configuration

| Item | Location |
|---|---|
| API Key | `~/.config/zenmux/key` |
| Plugin | `~/Library/Application Support/xbar/plugins/zenmux-usage.5m.py` |
| Refresh interval | Encoded in filename — rename to `zenmux-usage.10m.py` for 10-minute refresh |

### Update

Re-run the installer — it overwrites the plugin and optionally updates the key.

### License

MIT

---

## 中文

在 macOS 菜单栏实时显示 [ZenMux](https://zenmux.ai) 剩余用量（5小时和7天配额）的 xbar 插件。

```
菜单栏：  Z 615/800
─────────────────────
5h  614.8 / 800  (已用 23.1%)
7d  1372.0 / 3414  (已用 59.8%)
─────────────────────
更新于 23:19:33
```

### 环境要求

- macOS
- [xbar](https://xbarapp.com)（安装脚本会自动安装）
- ZenMux **Management API Key** — 在 [zenmux.ai](https://zenmux.ai) → Console → Management 创建

### 一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/yantao006/zenmux-usage/main/install.sh | bash
```

安装脚本会自动：
1. 安装 xbar（如未安装，通过 Homebrew）
2. 提示输入 Management API Key
3. 将 Key 安全存储至 `~/.config/zenmux/key`（权限 600）
4. 将插件复制到 xbar 插件目录
5. 启动 xbar

### 手动安装

```bash
git clone https://github.com/yantao006/zenmux-usage.git
cd zenmux-usage
bash install.sh
```

### 配置说明

| 项目 | 路径 |
|---|---|
| API Key | `~/.config/zenmux/key` |
| 插件文件 | `~/Library/Application Support/xbar/plugins/zenmux-usage.5m.py` |
| 刷新频率 | 由文件名控制 — 重命名为 `zenmux-usage.10m.py` 改为10分钟刷新 |

### 更新

重新运行安装脚本即可，会覆盖插件并可选更新 Key。

### 许可证

MIT
