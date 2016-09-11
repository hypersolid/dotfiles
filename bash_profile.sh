### Vars
export BUNDLER_EDITOR=atom
export PATH=$PATH:/usr/local/sbin:/Users/sol/.cargo/bin

### Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
alias rspec='rspec --order random:1'
alias RC="bundle exec rails c"
alias RS="bundle exec rails s"
alias be="bundle exec "

### Mongo
#export PATH="`m path`:$PATH"

### Style
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}
export PS1="\n\t \[\e[0;31m\]\w\[\e[m\]\[\033[32m\] \$(parse_git_branch)\[\033[00m\]$ "

### Git stuff
ticket() {
  git flow feature start $1
  git checkout feature/$1
  git push --set-upstream origin feature/$1
}

alias gpush="git push -u origin "
alias gpull="git pull --rebase origin "
alias GD="git diff "
alias GDC="git diff --cached"
alias GS="git status "
alias GL="git log --color -p"
alias GLO="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias GC="git commit -m"
alias GM="git merge --no-ff "

### Network
alias deploy="bundle exec cap staging deploy"
alias deploy1="bundle exec cap staging1 deploy"
alias deploy2="bundle exec cap staging2 deploy"

tunnelup1() {
  ps aux | grep 'sleep 8h' | grep -v 'grep' | awk '{ print $2 }' | xargs kill
  ssh -f -L 27018:127.0.0.1:27017 lenta@s1.ed.lenta.ru sleep 8h
  ssh -f -L 5433:127.0.0.1:5432 lenta@s1.ed.lenta.ru sleep 8h
}

tunnelup2() {
  ps aux | grep 'sleep 8h' | grep -v 'grep' | awk '{ print $2 }' | xargs kill
  ssh -f -L 27018:127.0.0.1:27017 lenta@s2.ed.lenta.ru sleep 8h
  ssh -f -L 5433:127.0.0.1:5432 lenta@s2.ed.lenta.ru sleep 8h
}

tunnelup() {
  ps aux | grep 'sleep 28000' | grep -v 'grep' | awk '{ print $2 }' | xargs kill
  ssh -f -L 27018:127.0.0.1:27017 gzt@ed.stage.gazeta.ru sleep 28000
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
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH


# Autocompletion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


# git sweets

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

export PIP_REQUIRE_VIRTUALENV=true

export PATH=$PATH:~/rnd/sonarcube/sonar-scanner-2.6.1/bin
export GOPATH=/Users/sol/golang:/Users/sol/development/fwd


. ~/Virtualenvs/stack/bin/activate
