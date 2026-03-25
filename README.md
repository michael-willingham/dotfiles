# dotfiles

This repository is the source of truth for my development environment, managed with [chezmoi](https://www.chezmoi.io/).

It is intended to control all of my personal configuration, including:

- Codex
- Fish
- Ghostty
- Neovim
- Git
- Shell tooling
- Terminal configuration
- Other machine-specific and cross-machine developer setup

## Goals

- Keep my full config portable and reproducible
- Manage changes declaratively with `chezmoi`
- Sync the same setup across machines with minimal manual steps

## Usage

Initialize a new machine with `chezmoi` and this repo:

```sh
chezmoi init https://github.com/michael-willingham/dotfiles.git
chezmoi apply
```

Edit managed files through `chezmoi`:

```sh
chezmoi edit ~/.config/fish/config.fish
chezmoi edit ~/.config/nvim/init.lua
chezmoi edit ~/.config/Cursor/User/settings.json
```

Review pending changes:

```sh
chezmoi diff
```

Apply updates:

```sh
chezmoi apply
```

## One-time Setup Scripts

chezmoi will automatically run the following scripts **once** on first apply (tracked by content hash, so they re-run only if the script itself changes):

| Script | Purpose |
|--------|---------|
| `run_once_install-nanobrew.sh` | Installs [nanobrew](https://github.com/nicehash/nanobrew) to `/opt/nanobrew` |

## Notes

- Secrets should be managed separately from this repository unless explicitly encrypted through `chezmoi`.
- Some configs may eventually use templates, scripts, or machine-specific conditionals as this setup grows.
