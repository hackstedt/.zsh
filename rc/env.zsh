#environement variables
#export LD_LIBRARY_PATH=/usr/lib/gcc/i486-pc-linux-gnu/4.4.2
export HISTORY_IGNORE='(alias( *)#|l[ls]#( *)#|jobs|[bf]g( *)#|exit|reset|cl(ear)#|cd[(..)( ..)]#|pwd|uu|dist-upgrade|aptclean|ac[sp]( *)#)'
export HISTSIZE=5120
export SAVEHIST=5120
export HISTFILE=~/.zsh/.history

# 256 Colors for vim:
# Set this variable depending on which terminal multiplexer is running.
if [ -n "$TMUX" ]; then
  export TERM=screen-256color # for vim within tmux
else
  export TERM=xterm-256color  # for vim within screen
fi

# Say how long a command took, if it took more than n seconds
export REPORTTIME=10
