#!/usr/bin/sh
# .config/shell/profile.sh
# @since 2023,2024,2025,2026
# set universal ENV, use `/bin/sh`(-> `/bin/dash`) for better efficiency

[ "$UID" -eq 0 ] || umask 022 # dir/file:755/644

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:${PATH}"
[ -d "$HOME/.local/sbin" ] && export PATH="$HOME/.local/sbin:${PATH}"
[ -d "/usr/share/neomutt/oauth2" ] && export PATH="${PATH}:/usr/share/neomutt/oauth2"

[ -x /usr/bin/bat ] && export MANROFFOPT="-c" && export MANPAGER="sh -c 'col -bx | bat --pager \"less -XR\" -l man -p'"
export MANWIDTH=80

# 2026-08-20: 已移除——XKB_DEFAULT_OPTIONS 会让 libxkbcommon 在"未显式指定 options"
# 的所有键位里注入 swap（caps:swapescape/altwin:swap_alt_win），这正是 river 上
# Esc/Alt 一直"被交换"的根因。键位映射已全部移交 kanata 按设备处理。
# export XKB_DEFAULT_OPTIONS=caps:swapescape,altwin:swap_alt_win

export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 # locale
export EDITOR="/usr/bin/nvim"
export PAGER="/usr/bin/less"
export DVTM_EDITOR="/usr/bin/vim"
export DVTM_PAGER="/usr/bin/less -R"
export BROWSER="qutebrowser"
# QtWebEngine performance: Skia renderer + zero-copy + GPU raster + hardware video decode
export QTWEBENGINE_CHROMIUM_FLAGS="--enable-features=UseSkiaRenderer,VaapiVideoDecodeLinuxGL --enable-zero-copy --num-raster-threads=4 --enable-gpu-rasterization"

export XDG_DOWNLOAD_DIR="$HOME/dls"
export XDG_DOCUMENTS_DIR="$HOME/doc"
export XDG_MUSIC_DIR="$HOME/mus"
export XDG_PICTURES_DIR="$HOME/pic"
export XDG_VIDEOS_DIR="$HOME/vid"
export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/fzfrc"

export XDG_CONFIG_HOME="$HOME/.config"      # analogous to /etc
export XDG_CACHE_HOME="$HOME/.cache"        # analogous to /var/cache
export XDG_DATA_HOME="$HOME/.local/share"   # analogous to /usr/share
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/1000"
# xdg-desktop-portal: required for portal backend selection (matches UseIn in .portal files)
# 当前桌面环境为 GNOME(river 时代遗留的 river 值会破坏 GNOME 集成,如 Settings 拒跑)
export XDG_CURRENT_DESKTOP=river
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
#export DBUS_SESSION_BUS_ADDRESS="/run/user/1000/bus"

export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export CALCHISTFILE="$XDG_CACHE_HOME/calc_history"
export CUDA_CACHE_PATH="$XDG_HOME_HOME/nv"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export W3M_DIR="$XDG_STATE_HOME/w3m"
export MAILCAPS="$XDG_CONFIG_HOME/mailcap"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
#export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GRIM_DEFAULT_DIR="$HOME/tmp/screenshots"

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket # ssh-agent
export ABDUCO_SOCKET_DIR=$XDG_RUNTIME_DIR # abduco

export QT_QPA_PLATFORMTHEME=qt5ct # qt theme
export QT_STYLE_OVERRIDE=adwaita-dark # qt theme
export _JAVA_AWT_WM_NONREPARENTING=1 # fix java blank window in xwayland-satellite

#export ELECTRON_OZONE_PLATFORM_HINT=wayland # electron
#export WLR_NO_HARDWARE_CURSORS=1 # external monitor cursor on nvidia

# fcitx
#export GTK_IM_MODULE=wayland
#export XMODIFIERS=@im=fcitx
#export QT_IM_MODULE="wayland;fcitx;ibus"

# ibus
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus
export STARDICT_DATA_DIR=~/.local/share/dict
export GNOME_KEYRING_CONTROL=/run/user/1000/keyring
