# Configure PATH
set -U fish_user_paths /usr/local/bin $fish_user_paths
set -U fish_user_paths /usr/bin $fish_user_paths
set -U fish_user_paths ~/.local/bin $fish_user_paths

# Set EDITOR to helix
set -gx EDITOR hx
set -gx XDG_CONFIG_HOME $HOME/.config

# Google Cloud (from .bash_profile)
set -gx GOOGLE_APPLICATION_CREDENTIALS ~/.config/gcloud/application_default_credentials.json
set -gx GOOGLE_CLOUD_PROJECT willingham-cloud
set -gx VERTEX_LOCATION global

# Configure homebrew
if test (uname) = Darwin
    eval ( /opt/homebrew/bin/brew shellenv )
end

# Configure mise
mise activate fish | source

# Enable oh-my-posh and zoxide for interactive shells
if status is-interactive
    oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/negligible.omp.json' | source
    zoxide init fish | source
end

# More macos specific setup
if test (uname) = Darwin
    set -U fish_user_paths ~/.lmstudio/bin $fish_user_paths
    source ~/.orbstack/shell/init2.fish 2>/dev/null || :
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/michael/.lmstudio/bin
# End of LM Studio CLI section
