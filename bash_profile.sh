### Vars
export BUNDLER_EDITOR=atom
export PATH=$PATH:/usr/local/sbin:/Users/sol/.cargo/bin

### Style
parse_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}
export PS1="\n\t \[\e[0;31m\]\w\[\e[m\]\[\033[32m\] \$(parse_branch)\[\033[00m\]$ "

### Git stuff
ticket() {
  git flow feature start $1
  git checkout feature/$1
  git push --set-upstream origin feature/$1
}

alias gpush="git push -u origin "
alias gpull="git pull --rebase origin "
alias gd="git diff "
alias gdc="git diff --cached"
alias gs="git status "
alias gl="git log --color -p"
alias glo="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gcm="git commit -m"
alias gco="git checkout"
alias gr="git reset"
alias ga="git add"

gc() {
  # git commit -m "${parse_branch} ${*}"
  message=`echo "$*"  | sed  's/\(.\)\(.*\)/\U\1\L\2/g'`
  git commit -m "$(parse_branch) $message"
}

### Misc
alias reload!='. ~/.bash_profile'
alias copy-ssh-key='cat ~/.ssh/id_rsa.pub | pbcopy'

run() {
    number=$1
    shift
    for i in `seq $number`; do
      $@
    done
}

### History
#export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
#export HISTSIZE=100000                   # big big history
#export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Autocompletion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

gitflow-cleanup-features(){
  branch=${1:-'develop'}

  git remote prune origin
  git branch --remote --merged $branch | tr -d '*' | sed 's/origin\///' | grep feature | xargs -I {} git push origin :{}

  git checkout $branch
  git branch --merged $branch | tr -d '*' | grep feature | xargs git branch -d
}

# Projects
random(){
export random_string=$(openssl rand -base64 32)
echo $random_string | pbcopy
echo "$(date) $random_string" >> .random_string
echo "copied to buffer..."
}

export GOPATH=~/go:~/development
export PATH=$PATH:/usr/local/go/bin:~/go/bin
