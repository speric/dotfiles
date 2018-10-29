export ZSH=~/.oh-my-zsh

ZSH_THEME="speric"
CASE_SENSITIVE="true"

plugins=()

source $ZSH/oh-my-zsh.sh

typeset -U path

path+=(
  ${HOME}/.rvm/bin
  ${HOME}/dev/dotfiles/bin
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
alias cb="git switch-branches"
alias clint="(cd frontend && npm run lint)"
alias console="bin/rails console"
alias cuke="bin/cucumber"
alias deploy="g co master && g pull && g push dokku master"
alias devtail="tail -f ./log/development.log"
alias effincamera="sudo killall VDCAssistant"
alias fe="(cd frontend && yarn start)"
alias flush_dns="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"
alias flush_redis="redis-cli flushall"
alias fr="flush_redis"
alias fs="foreman start"
alias mini="ruby -Ilib:test"
alias release="g cm && g pull && bin/rake release_notes | pbcopy"
alias reset_touchbar="pkill 'Touch Bar agent'; killall 'ControlStrip';"
alias rs="bin/rspec --no-profile" # --order defined
alias reload="source $HOME/.zshrc"
alias rs="recent_specs"
alias servers="fs --procfile=Procfile.local"
alias sr="bin/rspec --no-profile --tty"
alias srf="sr --only-failures"
alias testtail="tail -f ./log/test.log"
alias unhitch="hitch -u"
alias vi="vim"

# Functions

# Use `g` as a shortcut to `git`
# With no args, call `git status`
# h/t @pengwynn
function g() {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    git st
  fi
}

# Use `fzf` to browse/run recent specs
recent_specs() {
  $(history | cut -c 8- | grep spec | fzf)
}

# Pull latest, delete merged branches, rebuild dev env
fresh() {
  git pull
  git cleanup
  bin/fresh
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
