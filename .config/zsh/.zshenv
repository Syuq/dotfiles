# zsh environment file

# Default program.
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox-bin"
export AUR_HELPER="paru"

# Some default config directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# xinit
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc

# Ibus
export GTK_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=xim
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus
export GLFW_IM_MODULE=ibus

# Fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 40% --color=16 --border"

# Others
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # Warning: This line will break some DMs. Remove this line if you're using DMs like lightdm, gdm, sddm,...
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export _JAVA_AWT_WM_NONREPARENTING=1
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
