# Configure PATH
set -U fish_user_paths /usr/local/bin $fish_user_paths
set -U fish_user_paths /usr/bin $fish_user_paths
set -U fish_user_paths ~/.local/bin $fish_user_paths

# Configure homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Configure mise
mise activate fish | source

# Enable krew kubectl plugins
set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

if status is-interactive
    zoxide init fish | source
    macchina -m -p
    starship init fish | source
end
