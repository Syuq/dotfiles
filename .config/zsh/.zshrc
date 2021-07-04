# Automatically cd into typed directory
setopt autocd		

# Load aliases 
[ -f ~/.config/aliasrc ] && source ~/.config/aliasrc

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
HISTIGNORE=":ls:la:ll:cl:cd:fb:frepo:faur:"
HISTCONTROL=ignoreboth  # ignore space and duplicate entries

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files in autocomplete:
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

##### Load fzf files
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

##### show off =))
which neofetch > /dev/null && neofetch

##### Load zsh-syntax-highlighting.
# for Arch/Artix
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] &&
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# for Gentoo
[ -f /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh ] &&
    source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh 2>/dev/null

# Load zsh-autosuggestions
# for Arch/Artix
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] &&
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null
# for Gentoo (install from syaoran's overlay)
[ -f /usr/share/zsh/site-functions/zsh-autosuggestions/zsh-autosuggestions.zsh ] &&
    source /usr/share/zsh/site-functions/zsh-autosuggestions/zsh-autosuggestions.zsh 2> /dev/null

##### starship command to print prompt
which starship > /dev/null && eval "$(starship init zsh)"
