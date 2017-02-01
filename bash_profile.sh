### Vars
export EDITOR=atom
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

### Style
parse_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

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

### GIT
alias gpush="git push -u origin "
alias gpull="git pull --rebase origin "
alias gd="git diff "
alias gdc="git diff --cached"
alias gs="git status "
alias gl="git log --color -p"
alias glo="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gcm="git commit -m"
alias gcak="git commit --author='Alexander Krasnoschekov <akrasnoschekov@gmail.com>' -m"
alias gco="git checkout"
alias gr="git reset"
alias ga="git add"
alias gaa="git add -A"
gc() {
  message=`echo "$*"  | sed  's/\(.\)\(.*\)/\U\1\E\2/g'`
  git commit -m "$(parse_branch) $message"
}
gitflow-cleanup-features(){
  branch=${1:-'develop'}

  git remote prune origin
  git branch --remote --merged $branch | tr -d '*' | sed 's/origin\///' | grep feature | xargs -I {} git push origin :{}

  git checkout $branch
  git branch --merged $branch | tr -d '*' | grep feature | xargs git branch -d
}


### MISC
alias reload!='. ~/.bash_profile'
alias copy-ssh-key='cat ~/.ssh/id_rsa.pub | pbcopy'

run() {
  number=$1
  shift
  for i in `seq $number`; do
    $@
  done
}

random() {
  export random_string=$(openssl rand -base64 32)
  echo $random_string | pbcopy
  echo "$(date) $random_string" >> .random_string
  echo "copied to buffer..."
}

remote_shell() {
  if [ -n "$SSH_CLIENT"] || [ -n "$SSH_TTY" ]; then
    echo ""
  else
    echo " $(hostname) "
  fi
}

### BASH
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

export PS1="\n\e[0;94m\]\$(remote_shell)\[\e[m\]\t \[\e[0;31m\]\w\[\e[m\]\[\033[32m\] \$(parse_branch)\[\033[00m\]$ "
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

### Golang
export GOPATH=~/development:~/go
export PATH=$PATH:/usr/local/go/bin:~/go/bin

### Python
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

### Extras
if [ -d ~/scripts ]; then
  . ~/scripts/*
fi
