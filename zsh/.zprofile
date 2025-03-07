export EDITOR=nvim
export OPENER=mimeo
export TERM=kitty
export BROWSER=firefox
export GTK_USE_PORTAL=1
export MOZ_USE_XINPUT2=1
export PATH=$PATH:$HOME/.spicetify
export PATH=$PATH:/opt/android-sdk/platform-tools
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/bin/*
export PATH=$PATH:$HOME/.local/bin/kitty-sessions
export PATH=$PATH:$HOME/.local/bin/subtitles
export GOPATH=$HOME/Dev/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.cargo/bin
export MOZ_DISABLE_RDD_SANDBOX=1
export LIBVA_DRIVER_NAME=nvidia
export NVD_BACKEND=direct
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export WLR_NO_HARDWARE_CURSORS=1
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=qt6ct
export GRIMBLAST_EDITOR="satty -o %F_%T.png --filename"

# fix dolphin open with dialog being empty
export XDG_MENU_PREFIX=arch-

# export PYENV_ROOT=$HOME/.pyenv
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec Hyprland
fi
