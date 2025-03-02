# Configure PATH
set -U fish_user_paths /usr/local/bin $fish_user_paths
set -U fish_user_paths /usr/bin $fish_user_paths
set -U fish_user_paths ~/.local/bin $fish_user_paths

# Configure homebrew
if test (uname) = "Darwin"
    eval ( /opt/homebrew/bin/brew shellenv )
end

# Configure mise
~/.local/bin/mise activate fish | source

# Enable krew kubectl plugins
set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

if status is-interactive
    macchina
    zoxide init fish | source
end
