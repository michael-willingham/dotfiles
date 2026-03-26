# Configure PATH in priority order
fish_add_path -m -g /opt/nanobrew/prefix/bin /usr/local/bin /usr/bin ~/.local/bin

set -gx EDITOR nvim
set -gx GPG_TTY (tty)
set -gx XDG_CONFIG_HOME $HOME/.config

for completion_dir in /opt/nanobrew/prefix/opt/*/share/fish/vendor_completions.d
    if test -d $completion_dir
        if not contains -- $completion_dir $fish_complete_path
            set -ga fish_complete_path $completion_dir
        end
    end
end

for function_dir in /opt/nanobrew/prefix/opt/fish/vendor_functions.d
    if test -d $function_dir
        if not contains -- $function_dir $fish_function_path
            set -ga fish_function_path $function_dir
        end
    end
end

for conf_dir in /opt/nanobrew/prefix/opt/fish/vendor_conf.d
    if test -d $conf_dir
        for conf in $conf_dir/*.fish
            if test -f $conf
                source $conf
            end
        end
    end
end

if test -x /opt/nanobrew/prefix/bin/nb
    /opt/nanobrew/prefix/bin/nb completions fish | source
end

# macOS specific setup
if test (uname) = Darwin
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :
end

# Enable oh-my-posh and zoxide for interactive shells
if status is-interactive
    oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/spaceship.omp.json' | source
    zoxide init fish | source
end
