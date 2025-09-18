#!/usr/bin/env bash
set -euo pipefail

# Detect architecture
ARCH="$(uname -m)"
if [[ "$ARCH" == "arm64" ]]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/usr/local"
fi

# Check if Homebrew is already installed
if ! command -v brew >/dev/null 2>&1; then
  echo "[INFO] Homebrew not found. Installing to $BREW_PREFIX ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "[INFO] Homebrew already installed at $(command -v brew)"
fi

# Confirm installation
brew --version || {
  echo "[ERROR] Homebrew installation failed."
  exit 1
}

