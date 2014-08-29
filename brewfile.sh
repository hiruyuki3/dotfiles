#!/bin/sh

# update brew
brew update

# update formula
brew upgrade

# add repositories
brew tap caskroom/cask
brew tap caskroom/versions
brew tap peco/peco
brew tap homebrew/binary

# install brew-cask
brew install brew-cask

# install brew package
brew install git
brew install tig
brew install tmux
brew install zsh
brew install mobile-shell
brew install wget
brew install curl
brew install w3m
brew install jq
brew install ansible
brew install packer
brew install mysql
brew install tomcat
brew install android-sdk
brew install typesafe-activator
brew install node
brew install go
brew install peco
brew install pwgen
brew install rbenv
brew install ruby-build


# install cask package
brew cask install iterm2
brew cask install java6
brew cask install java7
brew cask install eclipse-jee
brew cask install android-studio
brew cask install dropbox
brew cask install skype
brew cask install evernote
brew cask install virtualbox
brew cask install vagrant
brew cask install boot2docker

brew cask install alfred
brew cask install dash
brew cask install heroku-toolbelt
brew cask install mysqlworkbench
brew cask install keepassx
brew cask install macvim-kaoriya
brew cask install sublime-text3
brew cask install mou
brew cask install kobito
brew cask install karabiner
brew cask install google-chrome
brew cask install google-web-designer
brew cask install google-drive
brew cask install sketch
brew cask install toggldesktop
brew cask install cyberduck
brew cask install prepros
brew cask install gimp-lisanet
brew cask install fluid
brew cask install sourcetree

# link the cask programs in alfred
brew cask alfred link

# remove old versions
brew cleanup
brew cask cleanup
