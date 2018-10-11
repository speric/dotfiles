export ZSH=~/.oh-my-zsh

ZSH_THEME="speric"
CASE_SENSITIVE="true"

plugins=()

source $ZSH/oh-my-zsh.sh

typeset -U path

path+=(
  ${HOME}/.rvm/bin
  /usr/local/opt/mysql@5.6/bin
  /usr/local/opt/node@6/bin
  /usr/local/sbin
)

export EDITOR="vi"
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'

setopt auto_cd
cdpath=($HOME/dev)

# .localrc: for stuff you don't want
# in your public, versioned repo
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# Aliases
alias ag="ag --path-to-ignore ~/.agignore"
alias be="RUBYOPT=W0 bundle exec"
alias clean-branches="git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D"
alias clint="(cd frontend && npm run lint)"
alias console="bin/rails console"
alias cuke="bin/cucumber"
alias deploy="git co master && git pull && git push dokku master"
alias devtail="tail -f ./log/development.log"
alias effincamera="sudo killall VDCAssistant"
alias fe="(cd frontend && yarn start)"
alias flush_dns="sudo killall -HUP mDNSResponder; \
  sudo killall mDNSResponderHelper; \
  sudo dscacheutil -flushcache; \
  sudo dscacheutil -flushcache; \
  sudo killall -HUP mDNSResponder"
alias flush_redis="redis-cli flushall"
alias fr="flush_redis"
alias fs="foreman start"
alias gcm="git co master"
alias giton="git checkout"
alias mini="ruby -Ilib:test"
alias prune="git remote prune origin"
alias release="gcm && git pull && bin/rake release_notes | pbcopy"
alias reset_author="git commit --amend --reset-author"
alias reset_touchbar="pkill 'Touch Bar agent'; killall 'ControlStrip';"
alias rs="bin/rspec --no-profile" # --order defined
alias recent="git recent"
alias reload="source $HOME/.zshrc"
alias servers="fs --procfile=Procfile.local"
alias squash="git rebase -i master"
alias sr="bin/rspec --no-profile --tty"
alias srf="sr --only-failures"
alias tag="ctags -R \
  --exclude=.git \
  --exclude=app/assets/javascripts \
  --exclude=app/views \
  --exclude=artifacts \
  --exclude=db \
  --exclude=frontend \
  --exclude=lib/console \
  --exclude=log \
  --exclude=spec \
  --exclude=tmp \
  --exclude=vendor \
  --exclude=public \
  ."
alias testtail="tail -f ./log/test.log"
alias unhitch="hitch -u"
alias vi="vim"

# Functions

# Use `fzf` to browse/select a recent git branch
# h/t @jeremywrowe
cb() {
  git checkout $(git short-recent | fzf)
}

# From https://github.com/pengwynn/dotfiles/blob/master/zsh/window.zsh
# Sets the window title nicely no matter where you are
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}
# source /usr/local/dev-env/ansible/mac_profile
# [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
