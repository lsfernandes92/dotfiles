#!/bin/bash
if [ "$(uname -s)" == "Linux" ]
then
  echo "Installing system packages for you..."
  echo "Create SSH keys before install system packages? (y/n): "
  read create_ssh
  echo "Create PGP keys before install system packages? (y/n): "
  read create_pgp

  # perform initial repo update
  echo "Updating repo..."
  sudo apt-get -y update

  # dunno packages
  sudo apt-get -qq install -y ack automake youtube-dl

  # basic packages
  echo "Installing basic packages..."
  sudo apt-get -qq install -y build-essential git zsh zsh-syntax-highlighting vim curl wget openssl gdb coreutils pkg-config make openssh-server autocutsel

  # ZSH framework management (oh-my-zsh)
  sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

  # some dev libraries
  echo "Installing dev libraries..."
  sudo apt-get -qq install -y libcurl4-gnutls-dev libgeoip-dev libopenssl-ruby libxml2 libxml2-dev ruby-dev libxslt1-dev dpkg-dev autoconf libreadline-dev libdnet-dev libffi-dev libpcap-dev libtool libmagic-dev libfreetype6-dev puma-dev rbenv  ruby-build

  # databases
  echo "Installing postgresql..."
  sudo apt -qq install -y postgresql postgresql-contrib

  # useful tools
  echo "Installing useful tools..."
  sudo apt-get -qq install -y zip unzip upx unrar-free jq dnsutils tcpdump httpie

  # security and privacy
  echo "Installing security and privacy stuffs..."
  sudo apt-get -qq install -y tor torsocks tor-arm socat dnscrypt-proxy secure-delete logcheck logcheck-database

  # Most used Apps
  echo "Installing system apps..."
  # Repo chrome dependecy
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

  sudo apt-get -y update
  sudo apt install -y google-chrome-stable docker firefox microsoft-edge-beta slack steam spotify

  if [[ $create_ssh == "y" || $create_ssh == "Y" || $create_ssh == "yes" ]]; then
      echo "**SSH Key Generation**"
      ssh-keygen -t rsa
  fi

  if [[ $create_pgp == "y" || $create_pgp == "Y" || $create_pgp == "yes" ]]; then
      echo "**PGP Key Generation**"
      sudo apt-get -qq install -y rng-tools
      sudo rngd -r /dev/urandom
      gpg --gen-key
  fi
fi
