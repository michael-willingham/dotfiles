#!/usr/bin/env fish

# Install fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source > /dev/null 2>&1 && fisher install jorgebucaran/fisher > /dev/null 2>&1

if fisher ls | grep -q "jorgebucaran/hydro"
    exit 0
end

fisher install jorgebucaran/hydro > /dev/null 2>&1
