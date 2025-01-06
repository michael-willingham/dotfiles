#!/usr/bin/env fish

# Install fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# do NOT use tty device for this script
set -gx TERM xterm-256color

# Install pure prompt
fisher install pure-fish/pure
