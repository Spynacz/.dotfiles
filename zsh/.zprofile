export EDITOR=nvim
export OPENER=mimeo
export TERM=kitty
export BROWSER=firefox
export GTK_USE_PORTAL=1
export GDK_DEBUG=portals
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
export LIBVA_DRIVER_NAME=radeonsi
export NVD_BACKEND=direct
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export WLR_NO_HARDWARE_CURSORS=1
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=qt6ct
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export WINEDLLPATH=$WINEDLLPATH:$HOME/.local/lib/discord-rpc/bin64:$HOME/.local/lib/discord-rpc/bin32
export PATH=$PATH:/opt/cuda:/opt/cuda/bin:/opt/cuda/nsight_compute:/opt/cuda/nsight_systems/bin
export NVCC_CCBIN='/usr/bin/g++'


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec startx 
fi
