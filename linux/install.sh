#!/bin/bash
if [ "$(uname -s)" == "Linux" ]
  echo "Installing system packages for you..."
  echo "Create SSH keys before install system packages? (y/n): "
  read create_ssh
  echo "Create PGP keys before install system packages? (y/n): "
  read create_pgp

  # perform initial repo update
  sudo apt-get -y update

  # dunno packages
  sudo apt-get -qq install -y ack automake libgpg-error libcaca libgit2 node ruby-build youtube-dl libksba libunistring libyaml icu4c libidn2

  # basic packages
  sudo apt-get -qq install -y build-essential git zsh zsh-syntax-highlighting vim curl wget openssl gdb coreutils pkg-config make openssh

  # some dev libraries
  sudo apt-get -qq install -y libxml2-dev libxslt1-dev dpkg-dev autoconf libreadline-dev libdnet-dev libffi-dev libpcap-dev libtool libmagic-dev libfreetype6-dev puma-dev rbenv

  # databases
  sudo apt-get -qq install -y postgresl

  # useful tools
  sudo apt-get -qq install -y zip unzip upx unrar-free jq dnsutils tcpdump httpie

  # security and privacy
  sudo apt-get -qq install -y tor torsocks tor-arm socat dnscrypt-proxy secure-delete dnssec-tools logcheck logcheck-database

  # Most used Apps
  echo "Installing system apps..."
  sudo apt-get -qq install -y 1password atom firefox google-chrome slack steam spotify virtualbox iterm2 docker

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

then
