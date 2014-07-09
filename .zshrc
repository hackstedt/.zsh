EDITOR=vim
PATH=/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/X11:$HOME/.rvm/bin:$PATH

# My functions (don't forget to modify fpath before call compinit !!)
fpath=($HOME/.zsh/functions $fpath)

# colors
eval `dircolors $HOME/.zsh/colors`

autoload -U zutil
autoload -U compinit
autoload -U complist

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

# Activation
compinit

# Resource files
for file in $HOME/.zsh/rc/*.rc; do
	source $file
done

source ~/.profile

# Regarding to the zsh-history-substring-search - Readme:
# "If you want to use zsh-syntax-highlighting along with this script,
# then make sure that you load it before you load this script" Therefore...
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ...and resource the other plugins afterwards
for file in $HOME/.zsh/plugins/*/*.zsh; do
  if [[ ! "$file" =~ "zsh-syntax-highlighting" ]]; then
    source $file
  fi
done

# Activate the brackets highlighter as well
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '\e[A' history-substring-search-up                # UP
bindkey '\e[B' history-substring-search-down              # DOWN

# Bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

echo $STY | egrep -e "[0-9]+\.vim$" && vim
echo $STY | egrep -e "[0-9]+\.rs$" && bundle exec rails s
echo $STY | egrep -e "[0-9]+\.guard$" && bundle exec guard
[[ -s "$HOME/.rvm/scripts/rvm"  ]] && source "$HOME/.rvm/scripts/rvm"
