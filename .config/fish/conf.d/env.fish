# Default program.
set -gx EDITOR nvim
set -gx TERMINAL st
set -gx BROWSER microsoft-edge-stable
set -gx AUR_HELPER paru

# Some default config directories
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache

# X11
set -gx XINITRC $XDG_CONFIG_HOME/X11/xinitrc
set -gx XSERVERRC $XDG_CONFIG_HOME/X11/xserverrc

# Ibus
set -gx GTK_IM_MODULE xim
set -gx XMODIFIERS @im=ibus
set -gx QT_IM_MODULE xim
set -gx QT4_IM_MODULE ibus
set -gx CLUTTER_IM_MODULE ibus
set -gx GLFW_IM_MODULE ibus

# Fzf
set -gx FZF_DEFAULT_OPTS "--layout=reverse --height 40% --color=16 --border"

# Others
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx WGETRC $XDG_CONFIG_HOME/wget/wgetrc
set -gx TERMINFO $XDG_DATA_HOME/terminfo
set -gx TERMINFO_DIRS $XDG_DATA_HOME/terminfo:/usr/share/terminfo
# Warning: This following line will break some DMs. Remove this line if you're using DMs like lightdm, gdm, sddm,...
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0
set -gx LESSHISTFILE -
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx IDEA_JDK /opt/openjdk-bin-11
set -gx _JAVA_AWT_WM_NONREPARENTING 1
