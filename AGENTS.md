# AGENTS.md

This is a [chezmoi](https://www.chezmoi.io/) **source-state** repository, not an application. Files here are renamed and copied into `$HOME` on `chezmoi apply`. Edit the source files in this repo; do not invent a parallel `$HOME` layout.

`README.md` is for humans. Keep it accurate when the managed surface changes. This file is for agents.

## Source map

| Source | Target / effect |
| --- | --- |
| `dot_zshrc` | `~/.zshrc` |
| `dot_p10k.zsh` | `~/.p10k.zsh` |
| `dot_gitconfig` | `~/.gitconfig` |
| `dot_config/ghostty/config` | `~/.config/ghostty/config` |
| `dot_config/nvim/init.lua` | `~/.config/nvim/init.lua` |
| `dot_config/mise/config.toml` | `~/.config/mise/config.toml` |
| `dot_config/k9s/*` | `~/.config/k9s/*` |
| `.chezmoidata/packages.yaml` | Template data only (not copied to `$HOME`) |
| `.chezmoitemplates/Brewfile.tmpl` | Rendered into the Homebrew script |
| `run_onchange_before_install-homebrew.sh.tmpl` | Before apply: install Homebrew if needed, then `brew bundle` |
| `run_after_10-install-oh-my-zsh.sh.tmpl` | After apply: install Oh My Zsh if missing |
| `run_after_20-set-shell-to-zsh.sh.tmpl` | After apply: set the login shell to zsh |
| `run_after_30-install-mise.sh.tmpl` | After apply: install mise to `~/.local/bin` if missing |
| `run_onchange_after_40-mise-install.sh.tmpl` | After apply, when `dot_config/mise/config.toml` changes: `mise trust` + `mise install` |

Repo docs stay in git and must not land in `$HOME`. `.chezmoiignore` currently excludes `README.md` and `AGENTS.md`. Chezmoi also ignores ordinary dotfiles in the source tree except its special files (`.chezmoiignore`, `.chezmoidata`, `.chezmoitemplates`, and similar).

## Naming

Chezmoi source attributes must stay in the documented order:

- Regular files: `encrypted_` → `private_` → `readonly_` → `empty_` → `executable_` → `dot_`
- Scripts: `run_` → `once_` or `onchange_` → `before_` or `after_`
- Directories: `remove_` → `external_` → `exact_` → `private_` → `readonly_` → `dot_`

`dot_foo` becomes `.foo`. `.tmpl` means Go templates with chezmoi data (`.chezmoi.os`, `.packages`, and so on). Scripts run in ASCII name order; the numeric prefixes on the `run_after_*` scripts are intentional.

Do not add a leading `.` to managed source files unless they are chezmoi special files. A file named `.zshrc` in this repo would be ignored, not applied.

## Where things belong

- **Homebrew packages and macOS casks:** `.chezmoidata/packages.yaml`. Common brews apply on macOS and Linux. Darwin/Linux brew lists are currently empty. Casks are Darwin-only and are skipped on Linux by `Brewfile.tmpl`.
- **CLI tool versions:** `dot_config/mise/config.toml`. Aliases in `dot_zshrc` (`bat`, `eza`, `zoxide`, `fastfetch`) assume mise-installed tools, not Homebrew. The mise binary is installed to `~/.local/bin` via `https://mise.run`, not Homebrew.
- **Shell behavior:** `dot_zshrc`. Keep the section order: instant prompt, environment, Homebrew, Oh My Zsh, integrations (including daily `mise up`), aliases, extra plugins, prompt, syntax highlighting last. `dot_p10k.zsh` is generated Powerlevel10k config; avoid hand-edits unless the user asks.
- **New managed dotfiles:** add them with chezmoi source names (`dot_…`, `dot_config/…`) in this repo. Prefer editing source files here over `chezmoi add` from a cloud-agent `$HOME`.

## Apply scripts

`chezmoi apply` is machine-mutating. Do not run it in this workspace unless the user asks.

- Homebrew script is `run_onchange_`: it reruns when the rendered script changes (including package-list changes).
- Oh My Zsh, login-shell, and mise-binary scripts are `run_after_`: they run on every apply, but exit early when already satisfied.
- The mise tools script is `run_onchange_after_`: it embeds a SHA256 of `dot_config/mise/config.toml` so `mise install` reruns when that file changes. Keep the hash comment if you rename or split the script.
- Scripts are templates gated to `darwin` and `linux`. They look for Homebrew at Workbrew, Apple Silicon, Intel, and Linuxbrew paths.

## Current constraints

- Default branch is `master`. Remote is `https://github.com/mhwtx/dotfiles.git`.
- The setup is macOS-first, but `dot_zshrc` now resolves Homebrew via `brew shellenv` (Workbrew, `/opt/homebrew`, `/usr/local`, Linuxbrew) and only sources plugins/themes that exist under `HOMEBREW_PREFIX`.
- Interactive shells run `mise self-update -y` and `mise up -y` in the background at most once every `MISE_AUTO_UP_HOURS` (default 24). Disable with `MISE_AUTO_UP=0`. Do not run that upgrade inline during prompt startup.
- GitHub `gh` credential helpers in `dot_gitconfig` also assume `/opt/homebrew/bin/gh`.
- Fish, Codex, Cursor `settings.json`, nanobrew, and `~/.agents` skill trees were removed. Do not restore them unless asked.
- There is no test suite, linter, or CI. For script changes, reason about idempotency, `set -euo pipefail`, and both Darwin and Linux paths.

## Always

- Keep `.chezmoiignore` in sync when adding more repo-only files (`README.md`, `AGENTS.md`, license, PR templates, and similar).
- Keep `README.md` aligned with the actual managed files, clone URL, and apply behavior.
- Put new Homebrew entries in `packages.yaml`, not by editing the generated Brewfile by hand.
- Leave secrets, tokens, and private keys out of this repo unless the user explicitly wants chezmoi encryption.
- Preserve existing comment style and keep shell scripts non-interactive (`NONINTERACTIVE=1`, Oh My Zsh `CHSH=no RUNZSH=no KEEP_ZSHRC=yes`, `MISE_YES=1`).

## Ask first

- Changing git `user.name` / `user.email`
- Adding or removing Homebrew casks the user will see on their Mac
- Rewriting `dot_p10k.zsh` instead of a small targeted edit
- Running `chezmoi apply`, `brew bundle`, or changing the login shell in any environment

## Never

- Commit credentials or rewrite history to hide them after the fact
- Apply `AGENTS.md` or `README.md` into `$HOME`
- Treat this checkout as the user's live home directory
- Reintroduce removed stacks (Fish, Codex, nanobrew) as drive-by cleanup
