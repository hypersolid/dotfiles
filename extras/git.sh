### GIT ###
parse_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}
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
