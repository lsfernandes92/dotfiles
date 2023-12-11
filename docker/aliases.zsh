alias d='docker $*'
alias dc='docker compose $*'
alias dcu="dc up -d"
alias dcd="dc down"
alias dsa='docker stop $(docker ps -a -q)'
alias dcr='dc run web $*'
alias dcb='dcr bash'
alias dcra='dcr bin/rails $*'
alias dcrr='dcr bin/rspec $*'
alias dsp='d system prune $*' 

# This repo: https://github.com/lsfernandes92/dockerizando_rails.git
# Contains the files needed to create a Ruby on Rails with Postgresql container.
# The following aliases meant to executed when I build a new rails
# project using the above repo
alias step1='dc run --no-deps web rails new . --force --database=postgresql'
alias step2='sudo chown -R $USER:$USER .'
alias step3='dc build'
alias step4='rm -f config/database.yml && mv database.yml config/'
alias step5='dcr bundle exec rake webpacker:install'
alias step6='dc up'
alias step7='dcr rake db:create'
