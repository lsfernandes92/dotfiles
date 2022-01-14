alias d='docker $*'
alias dc='docker-compose $*'
alias dcr='docker-compose run web $*'
alias dcb='docker-compose run web bash'
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dsa='docker stop $(docker ps -a -q)'
alias step1='docker-compose run --no-deps web rails new . --force --database=postgresql'
alias step2='sudo chown -R $USER:$USER .'
alias step3='docker-compose build'
alias step4='rm -f config/database.yml && mv database.yml config/'
alias step5='docker-compose up'
alias step6='docker-compose run web rake db:create'
