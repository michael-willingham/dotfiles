#!/usr/bin/env fish

if not command -v fisher > /dev/null
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source > /dev/null 2>&1 && fisher install jorgebucaran/fisher > /dev/null 2>&1
end

if not fisher ls | grep -q "jorgebucaran/hydro"
    fisher install jorgebucaran/hydro > /dev/null 2>&1
end

exit 0
