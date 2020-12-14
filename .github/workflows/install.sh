#!/bin/bash -e

echo "*** INIT: Install script"
sudo apt update
sudo apt install -y vim wget bash-completion
sudo apt upgrade -y
echo "*** END: Install script"
