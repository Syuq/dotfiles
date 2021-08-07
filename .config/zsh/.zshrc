# Automatically cd into typed directory
setopt autocd

# Load aliases 
[ -f ~/.config/aliasrc ] && source ~/.config/aliasrc

# History control
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
HISTORY_IGNORE="(ls|cd|pwd|la|ll|frepo|faur|fb|cl|cd ..)"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files in autocomplete:
_comp_options+=(globdots)

##### Load fzf files
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

PLUGINS_DIR="/usr/share/zsh/plugins"
# Load zsh-autosuggestions
# for Arch/Artix
[ -f $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh ] &&
    source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null

##### Load zsh-syntax-highlighting.

# for Arch/Artix
[ -f $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] &&
    source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# for Gentoo
[ -f /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh ] &&
    source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh 2>/dev/null

# vi mode
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

[ -f $PLUGINS_DIR/zsh-vim-mode/zsh-vim-mode.plugin.zsh ] &&
    source $PLUGINS_DIR/zsh-vim-mode/zsh-vim-mode.plugin.zsh

MODE_CURSOR_VIINS="#00ff00 blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady block"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

[ -f $PLUGINS_DIR/zsh-system-clipboard/zsh-system-clipboard.zsh ] &&
    source $PLUGINS_DIR/zsh-system-clipboard/zsh-system-clipboard.zsh

##### show off =))
which neofetch > /dev/null && neofetch

##### starship command to print prompt
which starship > /dev/null && eval "$(starship init zsh)"
