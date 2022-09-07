# ALIAS
alias python "python3.10"
alias ls "exa"
alias ll "exa -l -g --icons"
alias lla "ll -a"
alias llt "ll -T"
alias diff 'diff --color=auto'
alias grep 'grep --color=auto'
alias ip 'ip -color=auto'
alias pip_update 'pip list | cut -d" " -f1 | tail -n+3 | xargs pip install --upgrade'
alias mv "mv -v"
alias cp "cp -v"
alias rm "rm -v"
alias du "du -chsh"
# alias cmd "cmd.exe"
# alias pwsh "pwsh.exe"
# alias open "wslview"
alias vim "nvim"
# alias v "nvim"
alias battery "cat /sys/class/power_supply/BAT0/capacity"

# Docker
alias docker-start "systemctl start docker.service"
alias docker-stop "systemctl stop docker.service"

# Arch
alias pac "sudo pacman -S"
alias pac_autoremove "sudo pacman -Rcs $(pacman -Qdtq)"

# SET PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH $HOME/.pub-cache/bin $PATH
set -gx PATH ~/.nvm/versions/node/v16.15.1/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/nickp_real/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# Go path
set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# JAVA_HOME
set -gx JAVA_HOME /usr/lib/jvm/java-18-openjdk
set -gx PATH $JAVA_HOME/bin $PATH

# ANDROID_HOME
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx PATH $ANDROID_HOME/cmdline-tools/latest/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH
set -gx PATH $ANDROID_HOME/tools $PATH

# FLUTTER_ROOT
set -x FLUTTER_ROOT $HOME/Dev-tools/flutter
set -gx PATH $FLUTTER_ROOT/bin $PATH

# Rofi
set -gx PATH $HOME/.config/rofi/scripts $PATH

# SET VAR
set -Ux EDITOR nvim
set -Ux VISUAL $EDITOR
set -Ux SUDO_EDITOR $EDITOR 
set -Ux CLICOLOR 1
set -Ux LS_COLORS "ow=1;102;90"
set -Ux LC_ALL en_US.UTF-8
set -Ux LANG en_US.UTF-8
set -Ux LESS '-R --use-color -Dd+r$Du+b'
set -Ux MANPAGER 'nvim +Man!'

# fish var
set -Ux fish_color_command green 
set -Ux fish_color_normal brwhite
set -Ux fish_color_option blue
set -Ux fish_color_param blue
set -Ux fish_term24bit 1

# fzf
set -Ux fzf_preview_dir_cmd exa --all --color=always
# set fzf_fd_opts --hidden --exclude=.git
set -Ux FZF_DEFAULT_OPTS --color=fg:#abb2bf,bg:#282c34,hl:#61afef --color=fg+:#abb2bf,bg+:#393f4a,hl+:#528bff --color=info:#ebd09c,prompt:#98c379,pointer:#56b6c2 --color=marker:#e06c75,spinner:#c678dd,header:#56b6c2

# qt5
set -Ux QT_QPA_PLATFORMTHEME qt5ct
#
# STARSHIP INIT
starship init fish | source

# The Fuck INIT
thefuck --alias | source

# Start X server
if test -z "$DISPLAY"; and test "$XDG_VTNR" -eq 1
    exec startx
end
