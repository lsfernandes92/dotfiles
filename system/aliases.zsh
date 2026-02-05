alias ip="ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'"
alias dotfiles="$EDITOR ~/.dotfiles"
alias sonicpi-configs="$EDITOR ~/.sonic-pi/config/audio-settings.toml"
alias update-brew='brew update; brew upgrade; brew cleanup'
alias update-software='sudo softwareupdate -ia --verbose'
alias update!='update-brew && update-software && mas upgrade'
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias backup='mtmrbackup && vscodebackup'

# cli utility that displays
# a scrolling matrix-style
# digital rain effect in terminal
# 
# https://github.com/abishekvashok/cmatrix
alias matrix="cmatrix -s"

# navigation shortcuts
alias cls="clear"
alias home="cd"
alias desenv="cd ~/Documents/desenv"
alias l="ls -aln"