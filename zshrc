export ZSH=~/.oh-my-zsh

ZSH_THEME="speric"
CASE_SENSITIVE="true"

plugins=()

source $ZSH/oh-my-zsh.sh

typeset -U path

path+=(
  ${HOME}/dev/dotfiles/bin
  /usr/local/opt/mysql@8.0/bin
  /usr/local/opt/node@13/bin
  /usr/local/sbin
  ${HOME}/.rvm/bin
  /Library/Developer/CommandLineTools/usr/bin/
)

export EDITOR="vim"
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export HOMEBREW_NO_AUTO_UPDATE=1
export NVM_DIR="$HOME/.nvm"

setopt auto_cd
cdpath=($HOME/dev)

# Aliases
alias ag="ag --path-to-ignore ~/.agignore"
alias be="RUBYOPT=W0 bundle exec"
alias cb="git switch-branches"
alias console="bin/rails console"
alias creds="EDITOR=vim rails credentials:edit"
alias deploy="g co master && g push && g push heroku master"
alias devtail="tail -f ./log/development.log"
alias effincamera="sudo killall VDCAssistant"
alias fixpg="pg_ctl -D $HOMEBREW_PREFIX/var/postgres -l logfile start"
alias flush_dns="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"
alias flush_redis="redis-cli flushall"
alias fresh="freshen-up"
alias hl="heroku local"
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

# .localrc: for stuff you don't want in your public, versioned repo
if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi

# Wrap git with hub
if [[ -f `command -v hub` ]] ; then alias git=hub ; fi

# Functions

# Use `fzf` to browse/run recent specs
recent_specs() {
  $(history | cut -c 8- | grep spec | fzf)
}

random_sentence() {
  shuf -n 5 /usr/share/dict/words | tr "\n" " "
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

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
