# Configure PATH
set -U fish_user_paths /usr/local/bin $fish_user_paths
set -U fish_user_paths /usr/bin $fish_user_paths
set -U fish_user_paths ~/.local/bin $fish_user_paths

# Set EDITOR
set -Ux EDITOR helix

# Configure homebrew
if test (uname) = Darwin
    eval ( /opt/homebrew/bin/brew shellenv )
end

# Configure mise
mise activate fish | source

# Enable krew kubectl plugins
set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

if status is-interactive
    oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/spaceship.omp.json' | source
    zoxide init fish | source
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/michael/.lmstudio/bin
# End of LM Studio CLI section

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/homebrew/Caskroom/miniconda/base/bin $PATH
    end
end
# <<< conda initialize <<<
