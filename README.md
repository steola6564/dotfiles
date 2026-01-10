# Dotfiles 🐯

Personal dotfiles managed with **Nix**❄️.

This repository contains my configuration for daily use across multiple
environments, with a focus on reproducibility and gradual cross-platform support.

---

- Nix Flake based configuration
- Home Manager centric
- Primarily user-level configuration, with **some system-level settings**
- Designed to be shared across macOS, Linux, VMs, and (eventually) WSL

On macOS, this repository also manages **system-related settings**
(e.g. Dock preferences) via `nix-darwin`.

Linux system-level configuration is **planned** and will be expanded in the future.

---

## Tech Stack

- **Nix / Nix Flakes**
- **Home Manager**
- **NixOS** (partially, via other repositories)
- **macOS (nix-darwin)**
- Shell / CLI tools
- Editors (e.g. Neovim)

---

## Supported Environments

### ✅ macOS (Darwin)

- Primary development environment
- Managed with `nix-darwin` + Home Manager
- Most configurations are tested here

### 🚧 Linux

- Planned
- Some Home Manager modules are expected to work
- Full setup is not finalized yet

### 🚧 WSL

- Planned
- Not yet fully configured
- Will share Home Manager configurations where possible

### 🧪 VM Environments

- Used for testing and experiments
- Stability is not guaranteed

---

## Related Repositories

This repository interacts with the following repositories:

- [**Home server**](https://github.com/steola6564/home-server/tree/main)
  - Infrastructure and self-hosted services
  - Uses Proxmox + NixOS
  - May reuse parts of Home Manager configuration

- [**VM dotfiles**](https://github.com/steola6564/vm-dotfiles)
  - Sandbox environments (e.g. UTM on macOS)
  - Used for testing and validation

- [**nix-cloudflared**](https://github.com/steola6564/nix-cloudflared)
  - Single-purpose configuration
  - Personal use only

Each repository has a separate responsibility to avoid tight coupling.

---

## Usage

### Update flake inputs

```sh
nix flake update
```

### Apply configuration

#### NixOS

```sh
sudo nixos-rebuild switch --flake .#Home
```

#### Home Manager
```sh
home-manager switch --flake .#Home
```

---

## Notes

- Not all configurations are portable across all platforms

- Some modules may be macOS-first at the moment

- Linux / WSL support will be expanded over time

