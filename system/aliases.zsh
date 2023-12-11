# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Shortcuts
alias ip="ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'"
alias dotfiles="code ~/.dotfiles"
alias update-brew='brew update; brew upgrade; brew cleanup'
alias update-software='sudo softwareupdate -ia --verbose'
alias update='update-brew && update-software && mas upgrade'
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
