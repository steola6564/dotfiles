#!/usr/bin/env bash
set -euo pipefail

# Detect architecture
ARCH="$(uname -m)"
if [[ "$ARCH" == "arm64" ]]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/usr/local"
fi

# Install Rosetta (only if Apple Silicon)
if [[ "$ARCH" == "arm64" ]]; then
  if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
    echo "[INFO] Rosetta 2 not found. Installing..."
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
  else
    echo "[INFO] Rosetta 2 already installed."
  fi
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

