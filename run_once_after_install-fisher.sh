#!/bin/bash

# change to fish shell for the following commands
chsh -s /usr/bin/fish

# Install fisher if it is not already installed
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install pure prompt
fisher install pure-fish/pure
