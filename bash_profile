### Vars
export EDITOR=vim
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

### SSH
ssh-add ~/.ssh/id_rsa > /dev/null 2>&1
_complete_ssh_hosts ()
{
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
  cut -f 1 -d ' ' | \
  sed -e s/,.*//g | \
  grep -v ^# | \
  uniq | \
  grep -v "\[" ;
  cat ~/.ssh/config | \
  grep "^Host " | \
  awk '{print $2}'
  `
  COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
  return 0
}
complete -F _complete_ssh_hosts ssh
alias copy-ssh-key='cat ~/.ssh/id_rsa.pub | pbcopy'

### MISC
alias reload!='. ~/.bash_profile'

# Linux boxes:
# alias pbcopy='xclip -selection clipboard'
# alias pbpaste='xclip -selection clipboard -o'

### Extras
DOTFILES_EXTRAS=~/dotfiles/extras
if [ -d $DOTFILES_EXTRAS ]; then
  for extra in $DOTFILES_EXTRAS/*; do
    source $extra
  done
fi

### BASH settings
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

export PS1="\n\[\e[0;94m\]\$(remote_shell)\[\033[00m\]\t \[\e[0;31m\]\w\[\e[m\]\[\033[32m\] \$(parse_branch)\[\033[00m\]$ "
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

