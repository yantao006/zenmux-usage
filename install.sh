#!/usr/bin/env bash
set -euo pipefail

REPO="yantao006/zenmux-usage"
PLUGIN_NAME="zenmux-usage.5m.py"
PLUGIN_DIR="$HOME/Library/Application Support/xbar/plugins"
KEY_FILE="$HOME/.config/zenmux/key"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BOLD='\033[1m'; NC='\033[0m'

info()    { echo -e "${BOLD}$*${NC}"; }
success() { echo -e "${GREEN}✓ $*${NC}"; }
warn()    { echo -e "${YELLOW}! $*${NC}"; }
die()     { echo -e "${RED}✗ $*${NC}" >&2; exit 1; }

# ── macOS check ──────────────────────────────────────────────────────────────
[[ "$OSTYPE" == darwin* ]] || die "This plugin requires macOS."

# ── Homebrew ─────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ── xbar ─────────────────────────────────────────────────────────────────────
if [[ ! -d "/Applications/xbar.app" ]]; then
  info "Installing xbar..."
  brew install --cask xbar
  success "xbar installed"
else
  success "xbar already installed"
fi

# ── Plugin ───────────────────────────────────────────────────────────────────
mkdir -p "$PLUGIN_DIR"

PLUGIN_URL="https://github.com/$REPO/releases/latest/download/$PLUGIN_NAME"
# Fall back to raw main if no release exists yet
RAW_URL="https://raw.githubusercontent.com/$REPO/main/$PLUGIN_NAME"

info "Downloading plugin..."
if curl -fsSL "$PLUGIN_URL" -o "$PLUGIN_DIR/$PLUGIN_NAME" 2>/dev/null; then
  success "Plugin downloaded from release"
elif curl -fsSL "$RAW_URL" -o "$PLUGIN_DIR/$PLUGIN_NAME" 2>/dev/null; then
  success "Plugin downloaded from main branch"
else
  die "Could not download plugin. Check your internet connection."
fi

chmod +x "$PLUGIN_DIR/$PLUGIN_NAME"

# ── API Key ───────────────────────────────────────────────────────────────────
mkdir -p "$(dirname "$KEY_FILE")"

if [[ -f "$KEY_FILE" ]]; then
  warn "Key file already exists at $KEY_FILE"
  read -rp "Overwrite with a new key? [y/N] " overwrite
  if [[ "$overwrite" =~ ^[Yy]$ ]]; then
    read -rsp "Enter your ZenMux Management API Key: " key; echo
    printf '%s' "$key" > "$KEY_FILE"
    chmod 600 "$KEY_FILE"
    success "Key updated"
  else
    success "Keeping existing key"
  fi
else
  read -rsp "Enter your ZenMux Management API Key: " key; echo
  printf '%s' "$key" > "$KEY_FILE"
  chmod 600 "$KEY_FILE"
  success "Key stored at $KEY_FILE (mode 600)"
fi

# ── Launch xbar ───────────────────────────────────────────────────────────────
info "Opening xbar..."
open /Applications/xbar.app

echo
echo -e "${GREEN}${BOLD}Installation complete!${NC}"
echo "The menu bar will show your ZenMux quota within a few seconds."
echo "If xbar asks for a plugins folder, select:"
echo "  $PLUGIN_DIR"
