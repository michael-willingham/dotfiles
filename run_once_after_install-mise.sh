#!/bin/bash

# Install mise if it is not already installed
if ! command -v mise &> /dev/null
then
    curl https://mise.run | sh
fi

# Install all mise packages
~/.local/bin/mise i -y --silent
