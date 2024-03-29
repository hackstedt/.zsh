alias rm="rm -i"
alias cp="cp -i"
alias ls="ls --color=auto"
alias l="ls -aFlh --group-directories-first --color=auto --time-style=+'%d.%m.%Y %H:%M:%S'"
# Show the 10 newest files/directories in current directory
alias lt="ls -aFlhtr --group-directories-first --color=auto --time-style=+'%d.%m.%Y %H:%M:%S' | tail"
# Show the 10 newest files combined in current and sub directories
alias ft="find . -type f -print0 | xargs -0 stat --format '%Y :%y %n' | sort -nr | cut -d: -f2- | head"
alias cl="clear"
alias i="sudo apt-get install"
alias acs="apt-cache search"
alias acp="apt-cache policy"
alias uu="sudo apt-get update; sudo apt-get upgrade"
alias dist-upgrade="sudo apt-get dist-upgrade"
alias aptclean="s apt-get check; s apt-get clean; s apt-get autoremove"
alias s="sudo"
alias p1="ping -c1"
alias reboot="shutdown -r now"
alias cd..="cd .."
alias mkdir_date="mkdir $(date +'%d_%m_%Y-%H_%MUhr')"
alias vl="vim -c':e#<1'"
alias v="vim"
alias vn="vim -u NONE"

follow() {
  IFS=$'\n'
  PS3="cd to: "
  select dir in $(lsof -d cwd 2>/dev/null | awk "(/zsh|bash/) && \$NF != \"$PWD\" {print substr(\$0, index(\$0,\$9))}"); do cd $dir; break; done
}

alias -g G='| fgrep -i'

export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=2 --no-init --window=-4'
# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

gupy() {
  cd "$1"
  pidFile="/tmp/python_SimpleHTTPServer_pid"
  (( $+commands[python3] )) && (python3 -m http.server 7777 & echo $! > $pidFile) || (python -m SimpleHTTPServer 7777 & echo $! > $pidFile)
  guard -G ~/.config/Guardfile -w .
  kill $(cat /tmp/python_SimpleHTTPServer_pid)
  rm -f $pidFile
}
alias guardthis="guard -G ~/.config/Guardfile -w ."

alias 7777="(( $+commands[python3] )) && python3 -m http.server 7777 || python -m SimpleHTTPServer 7777"

rg() {rgrep --color -insTI -A3 -B2 --exclude-dir={log,tmp} $1 .}

fim() {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    vim $(sed -n "${1}p" ~/.fimds)
  else
    find_pattern=$([[ "$1" == "f" ]] && echo "$2" || echo "$1")
    sed_pattern=$(tr -d '*' <<< "$find_pattern")
    find "$PWD" -name "$find_pattern" | tee ~/.fimds | nl -w2 -s' ' |\
      sed -r "s#$PWD/#//#; s#([^/]*)(/)(.*/)(.*)($sed_pattern)(.*)#\
\o033[34m\1\o033[0m\
\o033[2;34m$PWD\o33[0m\
\o033[34m\3\o033[0m\
\o033[95m\4\o033[0m\
\o033[1;95m\5\o033[0m\
\o033[95m\6\o033[0m\
#"
  fi
}

bu () { cp -a ${1%/}{,--$(date +%Y-%m-%d_%Hh%M)}; }

# alias rs="bundle exec rails s"
if [[ -e "/usr/lib/libtcmalloc_minimal.so.?" ]]; then
  malloc=`ls /usr/lib/libtcmalloc_minimal.so.?`
fi
alias ts="RAILS_ENV=development RUBY_GC_MALLOC_LIMIT=90000000; LD_PRELOAD=$malloc bundle exec thin start -p 3000"
alias rs="bin/rails s"
alias rc="bin/rails c"
alias rcs="bin/rails c --sandbox"
alias bbb="echo '\e[0;36mrun: bundle install... \e[0m';
            bundle install;
            echo '\e[0;36mrun: bundle exec rake db:migrate... \e[0m';
            bundle exec rake db:migrate;
            echo '\e[0;36mrun: bundle exec rake db:test:prepare... \e[0m';
            bundle exec rake db:test:prepare;
            echo '\e[0;36mrun: bundle exec rails s (with gc-malloc-settings)... \e[0m';
            rs"
alias tm="tunnelmagick"
alias tmm="tunnelmagick `date +%s`"

# do a du -hs on each dir on current path
alias lsdir="for dir in *;do;if [ -d \$dir ];then;du -hsL \$dir;fi;done"

vim_less_macro=$(find /usr/share/vim -name 'less.vim' | grep macros)
[ ! -z $vim_less_macro ] && alias lv="vim -u $vim_less_macro"

# git
alias gs="git status"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc="git commit"
alias gcm="git commit -m"
alias gd="git diff"
alias go="git checkout"
alias gk="gitk --all&"
alias gg="git gui&"
alias gst="git stash"
alias gstp="git stash pop"
alias gl="git pull --rebase"
alias gh="git push"
alias gim="vim -p \$(git status --short | sed -n 's/^ M //p')"
alias gacd="git add .; git commit -am \"\$(date +\"%d.%m.%Y - %H:%M Uhr\")\""
gll() {git log --author='Sven' --no-merges --pretty='%+n%+cr%+an%+cD%+s%+H' -6 --stat --reverse | pr -2 -t -s\| -W$COLUMNS}

alias dh='dirs -v'
ds() {
  local dir
  select dir in $dirstack; do
    [[ -n "$dir" ]] && cd $dir || :
    break
  done
}

rom() {
  clear

  if [ -x "$1"  ]; then
    _command="./$@"
  else
    set -- "$(which $1)" "${@:2}"
    _command="$@"
  fi

  eval "$_command"

  inotifywait -m -e close_write . |
    while read -r directory events filename; do
      if [ -f "$filename" ]; then
        clear
        eval "$_command"
      fi
    done
}
