# zenmux-usage

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

## Requirements

- macOS
- [xbar](https://xbarapp.com) (installed automatically by the installer)
- A ZenMux **Management API Key** — create one at [zenmux.ai](https://zenmux.ai) → Console → Management

## One-line Install

```bash
curl -fsSL https://raw.githubusercontent.com/yantao006/zenmux-usage/main/install.sh | bash
```

The installer will:
1. Install xbar if not present (via Homebrew)
2. Prompt for your Management API Key
3. Store it securely in `~/.config/zenmux/key` (mode 600)
4. Copy the plugin to xbar's plugins directory
5. Launch xbar

## Manual Install

```bash
# 1. Clone the repo
git clone https://github.com/yantao006/zenmux-usage.git
cd zenmux-usage

# 2. Run the installer
bash install.sh
```

## Configuration

| Item | Location |
|---|---|
| API Key | `~/.config/zenmux/key` |
| Plugin | `~/Library/Application Support/xbar/plugins/zenmux-usage.5m.py` |
| Refresh interval | Encoded in filename — rename to `zenmux-usage.10m.py` for 10-minute refresh |

## Update

Re-run the installer — it overwrites the plugin and optionally updates the key.

## License

MIT
