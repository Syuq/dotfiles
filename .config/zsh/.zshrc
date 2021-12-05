# Automatically cd into typed directory
setopt autocd

# Load aliases 
source ~/.config/aliasrc 2> /dev/null

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

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

## Load zsh plugins
PLUGINS_DIR="/usr/share/zsh/plugins"

source /usr/share/fzf/key-bindings.zsh 2> /dev/null
source /usr/share/fzf/completion.zsh 2> /dev/null
source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
# This below line is required since zsh-syntax-highlighting on Gentoo
# is installed on different directory
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh 2> /dev/null
source $PLUGINS_DIR/zsh-vim-mode/zsh-vim-mode.plugin.zsh 2> /dev/null
source $PLUGINS_DIR/zsh-system-clipboard/zsh-system-clipboard.zsh 2> /dev/null

# Make zsh switch from insert mode to normal mode quicker
export KEYTIMEOUT=1

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6e6e6e"
MODE_CURSOR_VIINS="#00ff00 blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady block"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

##### show off =))
neofetch 2> /dev/null

##### starship command to print prompt
eval "$(starship init zsh)" 2> /dev/null
