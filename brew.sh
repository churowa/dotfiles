#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we're using the latest Homebrew.
brew update

# Upgrade any already-installed formula.
brew upgrade

# OpenSSL
brew install openssl
brew link --force openssl

brew install curl --with-openssl --with-nghttp2
brew link --force curl

# Install GNU core utilities (those that come with OS X are outdated).
brew install coreutils
brew install gnu-sed
sudo ln -sf /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Note: don't forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion

brew install git
brew install mercurial

brew install vim --with-lua --override-system-vi

brew install node

brew cleanup
