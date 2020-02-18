# case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# zstyle
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{yellow}%d%f%u'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' special-dirs true

# $ scp file username@<TAB><TAB>:/<TAB>
zstyle ':completion:*:(ssh|scp|ftp|rsync):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp|rsync):*' users $users

# Group results by category
zstyle ':completion:*' group-name ''

# Cursor doesn't go to the end, and completion is done from both ends.
setopt complete_in_word

# kill completion
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:kill:*' insert-ids single
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:processes' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
