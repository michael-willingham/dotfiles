#!/usr/bin/env bash
set -euo pipefail

# Cursor Cloud bootstrap: install mise, then the tools in
# dot_config/mise/config.toml. Idempotent.

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mise_bin="${HOME}/.local/bin/mise"
mise_config="${XDG_CONFIG_HOME:-$HOME/.config}/mise/config.toml"
src_config="${repo_root}/dot_config/mise/config.toml"

if [ ! -f "$src_config" ]; then
  echo "mise config not found at $src_config" >&2
  exit 1
fi

if [ ! -x "$mise_bin" ]; then
  echo "Installing mise to ${mise_bin}..."
  mkdir -p "$(dirname "$mise_bin")"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL https://mise.run | MISE_INSTALL_PATH="$mise_bin" MISE_QUIET=1 /bin/sh
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- https://mise.run | MISE_INSTALL_PATH="$mise_bin" MISE_QUIET=1 /bin/sh
  else
    echo "curl or wget is required to install mise." >&2
    exit 1
  fi
fi

if [ ! -x "$mise_bin" ]; then
  echo "mise was installed, but $mise_bin is still not executable." >&2
  exit 1
fi

mkdir -p "$(dirname "$mise_config")"
ln -sfn "$src_config" "$mise_config"

export PATH="${HOME}/.local/bin:${PATH}"
export MISE_YES=1

"$mise_bin" trust "$mise_config"
"$mise_bin" install -y

profile_snippet='
# cursor-mise
export PATH="$HOME/.local/bin:$PATH"
if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate bash --shims)"
fi
'

for rc in "${HOME}/.bashrc" "${HOME}/.profile"; do
  if [ -f "$rc" ] && grep -q '# cursor-mise' "$rc"; then
    continue
  fi
  printf '%s\n' "$profile_snippet" >> "$rc"
done
