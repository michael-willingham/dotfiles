#!/bin/sh
# run_once_install-nanobrew.sh
# Installs nanobrew the first time chezmoi applies this dotfiles repo.
# chezmoi tracks the content hash of this file and will not re-run it
# unless the script itself changes.
#
# The install script is fetched from the official nanobrew repository:
#   https://github.com/nicehash/nanobrew
# Review that script before running if you want to verify what it does.

set -e

NANOBREW_BIN="/opt/nanobrew/prefix/bin/nanobrew"

if [ -x "${NANOBREW_BIN}" ]; then
  echo "nanobrew is already installed, skipping."
  exit 0
fi

echo "Installing nanobrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nicehash/nanobrew/HEAD/install.sh)"
