EDITOR=vim
PATH=/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/X11:$HOME/.rvm/bin:$PATH

# My functions (don't forget to modify fpath before call compinit !!)
fpath=($HOME/.zsh/functions $fpath)


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Enable Ctrl-v to edit command line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line


bindkey ';5A' history-search-backward   # Ctr+UP
bindkey ';5B' history-search-forward    # Ctr+DOWN
bindkey '^K' kill-whole-line
bindkey "\e[1~" beginning-of-line       # Home (console)
bindkey "\e[H" beginning-of-line        # Home (xorg)
bindkey "\e[4~" end-of-line             # End (console)
bindkey "\e[F" end-of-line              # End (xorg)
bindkey "\e[2~" overwrite-mode          # Ins
bindkey "\e[3~" delete-char             # Delete
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line
bindkey ';2D' backward-word
bindkey ';2C' forward-word


source ~/.profile

# Regarding to the zsh-history-substring-search - Readme:
# "If you want to use zsh-syntax-highlighting along with this script,
# then make sure that you load it before you load this script" Therefore...

source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Activate the brackets highlighter as well
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# ...and resource the other plugins afterwards

source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# Bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '\e[A' history-substring-search-up                # UP
bindkey '\e[B' history-substring-search-down              # DOWN
# Bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

source ~/.zsh/plugins/zsh-autopair/autopair.zsh

eval $(dircolors -b ~/.zsh/plugins/LS_COLORS/LS_COLORS)

# Resource files
for file in $HOME/.zsh/rc/*; do
	source $file
done


autoload -U zutil
autoload colors; colors
autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit
autoload -U complist

echo $STY | egrep -e "[0-9]+\.vim$" && vim
echo $STY | egrep -e "[0-9]+\.rs$" && bundle exec rails s
echo $STY | egrep -e "[0-9]+\.guard$" && bundle exec guard
[[ -s "$HOME/.rvm/scripts/rvm"  ]] && source "$HOME/.rvm/scripts/rvm"
