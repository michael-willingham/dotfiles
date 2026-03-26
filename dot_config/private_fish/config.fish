# Configure PATH in priority order
fish_add_path -m -g /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/bin ~/.local/bin

set -gx EDITOR nvim
set -gx GPG_TTY (tty)
set -gx XDG_CONFIG_HOME $HOME/.config

# macOS specific setup
if test (uname) = Darwin
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :
end

# Enable oh-my-posh and zoxide for interactive shells
if status is-interactive
    oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/spaceship.omp.json' | source
    zoxide init fish | source
end
