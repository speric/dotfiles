export ZSH=~/.oh-my-zsh

ZSH_THEME="speric"
CASE_SENSITIVE="true"

plugins=()

source $ZSH/oh-my-zsh.sh

typeset -U path

path+=(
  ${HOME}/dev/dotfiles/bin
  ${HOME}/.ebcli-virtual-env/executables
  /usr/local/opt/mysql@8.0/bin
  /usr/local/opt/node@13/bin
  /usr/local/sbin
  ${HOME}/.rvm/bin
)

export EDITOR="vim"
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'

setopt auto_cd
cdpath=($HOME/dev)

# .localrc: for stuff you don't want in your public, versioned repo
if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi

# Aliases
alias ag="ag --path-to-ignore ~/.agignore"
alias be="RUBYOPT=W0 bundle exec"
alias cb="git switch-branches"
alias console="bin/rails console"
alias creds="EDITOR=vim rails credentials:edit"
alias deploy="g co master && g push && g push heroku master"
alias devtail="tail -f ./log/development.log"
alias effincamera="sudo killall VDCAssistant"
alias flush_dns="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"
alias flush_redis="redis-cli flushall"
alias fresh="freshen-up"
alias lint="yarn run lint"
alias logs="cd /usr/local/var/log"
alias mini="ruby -Ilib:test"
alias migrate="bin/rails db:migrate db:test:prepare"
alias reset_touchbar="pkill 'Touch Bar agent'; killall 'ControlStrip';"
alias rs="bin/rspec --no-profile"
alias reload="source $HOME/.zshrc"
alias rs="recent_specs"
alias sr="bin/rspec --no-profile --tty"
alias srf="sr --only-failures"
alias testtail="tail -f ./log/test.log"
alias unhitch="hitch -u"
alias vi="vim"
alias ys="yarn start"

# Wrap git with hub
if [[ -f `command -v hub` ]] ; then alias git=hub ; fi

# Functions

# Use `fzf` to browse/run recent specs
recent_specs() {
  $(history | cut -c 8- | grep spec | fzf)
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

archey -o
