#!/bin/bash

# Install mise if it is not already installed
curl https://mise.run | sh

# Install all mise packages
~/.local/bin/mise i -y --silent
