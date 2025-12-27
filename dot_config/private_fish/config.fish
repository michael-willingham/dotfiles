# Configure PATH
set -U fish_user_paths /usr/local/bin $fish_user_paths
set -U fish_user_paths /usr/bin $fish_user_paths
set -U fish_user_paths ~/.local/bin $fish_user_paths

# Set EDITOR to helix
set -gx EDITOR hx
set -gx XDG_CONFIG_HOME $HOME/.config

# macOS specific setup
if test (uname) = Darwin
    eval ( /opt/homebrew/bin/brew shellenv )
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :
end

# Configure mise
mise activate fish | source

# Enable oh-my-posh and zoxide for interactive shells
if status is-interactive
    oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/negligible.omp.json' | source
    zoxide init fish | source
    fastfetch
end
