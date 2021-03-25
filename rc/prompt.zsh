STARTSEC=0
ENDSEC=0

# ZLE_RPROMPT_INDENT must be set to -1 instead of 0,  otherwise the cursor will be offset as well
# https://github.com/Powerlevel9k/powerlevel9k/issues/110#issuecomment-395940663
ZLE_RPROMPT_INDENT=-1

precmd () {
  ENDSEC=$(date +%s)
  DIVSEC=$(expr $ENDSEC - $STARTSEC)
  PR_DIVSEC="$DIVSEC sec"

  local TERMWIDTH
  ((TERMWIDTH = ${COLUMNS}))

  PR_FILLBAR=""
  PR_PWDLEN=""

  if [[ "$TERM" == "linux" ]]; then
    local promptsize=${#${(%):--(%m:%l)--()--}}
  else
    local promptsize=${#${(%):--(%m:%l)---()---}}
  fi

  local pwdsize=${#${(%):-%~}}

  if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
  else
    PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
  fi
}

preexec () {
  STARTSEC=$(date +%s)
}


setprompt () {
  # Need this so the prompt will work.
  setopt prompt_subst

  # See if we can use colors.
  autoload colors zsh/terminfo

  if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
  fi

  for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    ((count = $count + 1))
  done
  PR_NO_COLOUR="%{$terminfo[sgr0]%}"

  # See if we can use extended characters to look nicer.
  # UTF-8 Fixed
  if [[ $(locale charmap) == "UTF-8" ]]; then
    PR_SET_CHARSET=""
    PR_SHIFT_IN=""
    PR_SHIFT_OUT=""
    PR_HBAR="─"
    PR_ULCORNER="┌"
    PR_LLCORNER="└"
    PR_URCORNER="┐"
    PR_LRCORNER="┘"
  else
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR='$PR_SHIFT_IN${altchar[q]:--}$PR_SHIFT_OUT'
    PR_ULCORNER='$PR_SHIFT_IN${altchar[l]:--}$PR_SHIFT_OUT'
    PR_LLCORNER='$PR_SHIFT_IN${altchar[m]:--}$PR_SHIFT_OUT'
    PR_LRCORNER='$PR_SHIFT_IN${altchar[j]:--}$PR_SHIFT_OUT'
    PR_URCORNER='$PR_SHIFT_IN${altchar[k]:--}$PR_SHIFT_OUT'
  fi

  # Decide if we need to set titlebar text.
  case $TERM in
    xterm*)
      PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
      ;;
    screen)
      PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
      ;;
    *)
      PR_TITLEBAR=''
      ;;
  esac

  # Decide whether to set a screen title
  if [[ "$TERM" == "screen" ]]; then
    PR_STITLE=$'%{\ekzsh\e\\%}'
  else
    PR_STITLE=''
  fi

  # Finally, the prompt.
  PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_RED$PR_SHIFT_IN$PR_ULCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
{$PR_MAGENTA%$PR_PWDLEN<...<%~%<<$PR_BLUE}\
$PR_SHIFT_IN$PR_HBAR$PR_RED$PR_HBAR${(e)PR_FILLBAR}$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
{$PR_GREEN%(!.%S%m%s.%m)$PR_GREEN:%l$PR_BLUE}\
$PR_SHIFT_IN$PR_HBAR$PR_RED$PR_URCORNER$PR_SHIFT_OUT$PR_RED$PR_SHIFT_IN$PR_LLCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
{${(e)PR_APM}$PR_YELLOW%D{%H:%M:%S}%(?..|$PR_LIGHT_RED%?)\
$PR_BLUE}$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_NO_COLOUR'

  RPROMPT='$PR_SHIFT_IN$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
{$PR_YELLOW%D{%a,%b%d}$PR_BLUE}\
$PR_SHIFT_IN$PR_HBAR$PR_RED$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOUR'

  PS2='$PR_RED$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_RED$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR'
}

setprompt
