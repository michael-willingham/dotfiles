# dotfiles

This repository is the source of truth for my development environment, managed with [chezmoi](https://www.chezmoi.io/).

It currently manages:

- Zsh, Oh My Zsh, and Powerlevel10k
- Git
- Ghostty
- Neovim
- [mise](https://mise.jdx.dev/) tool versions
- k9s
- Homebrew packages, plus macOS casks

`README.md` and `AGENTS.md` stay in the repo only. They are listed in `.chezmoiignore` so `chezmoi apply` does not copy them into `$HOME`.

## Goals

- Keep the full config portable and reproducible
- Manage changes declaratively with `chezmoi`
- Sync the same setup across machines with minimal manual steps

## Usage

Initialize a new machine with `chezmoi` and this repo:

```sh
chezmoi init https://github.com/mhwtx/dotfiles.git
chezmoi apply
```

On apply, chezmoi writes the managed dotfiles and runs the bootstrap scripts:

1. Install Homebrew if needed, then `brew bundle` the packages in `.chezmoidata/packages.yaml`
2. Install Oh My Zsh if it is missing
3. Set the login shell to zsh
4. Install [mise](https://mise.jdx.dev/) to `~/.local/bin` if it is missing
5. Run `mise install` when `~/.config/mise/config.toml` changes

Interactive zsh sessions also run `mise self-update` and `mise up` in the background at most once a day. Set `MISE_AUTO_UP=0` to disable that.

CLI tools such as `bat`, `eza`, `zoxide`, and `fastfetch` come from mise (`~/.config/mise/config.toml`), not from the Homebrew list.

Edit managed files through `chezmoi`:

```sh
chezmoi edit ~/.zshrc
chezmoi edit ~/.config/nvim/init.lua
chezmoi edit ~/.config/ghostty/config
```

Or edit the source files in this repository (`dot_zshrc`, `dot_config/…`) and apply.

Review pending changes:

```sh
chezmoi diff
```

Apply updates:

```sh
chezmoi apply
```

## Notes

- Secrets should stay out of this repository unless they are explicitly encrypted through `chezmoi`.
- Homebrew casks install on macOS only. Formulae in the common list install on both macOS and Linux.
- mise itself is installed to `~/.local/bin` with the official installer, not Homebrew.
- `~/.zshrc` loads Homebrew from Workbrew, Apple Silicon, Intel, or Linuxbrew when present, then sources zsh plugins from `HOMEBREW_PREFIX`.
