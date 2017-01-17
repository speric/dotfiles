export ZSH=/Users/ericfarkas/.oh-my-zsh

ZSH_THEME="bira"
CASE_SENSITIVE="true"

plugins=()

source $ZSH/oh-my-zsh.sh

export EDITOR="vi"
export PATH="$PATH:$HOME/.rvm/bin"

setopt auto_cd
cdpath=($HOME/dev)

# Aliases
alias be='RUBYOPT=W0 bundle exec'
alias clean-db='be rake db:drop db:create db:migrate db:seed && be rake RAILS_ENV=test db:migrate'
alias console='spring rails console'
alias deploy='git push origin master && git push dokku master'
alias devtail='tail -f ./log/development.log'
alias giton='git checkout '
alias lint='npm run lint'
alias mini='ruby -Ilib:test'
alias reset_author='git commit --amend --reset-author'
alias servers='foreman start --procfile=Procfile.local'
alias squash='git rebase -i master'
alias sr='spring rspec'
alias testtail='tail -f ./log/test.log'
