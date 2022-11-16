#!/bin/sh
# The Standard System Utilities task that one sees in debian-installer
# consist of packages with priority 'required', 'important' and 'standard'.
# One can safely assume that 'required' packages are already installed.

# Install packages with priority 'important'
apt-get install $(dpkg-query -W -f'${Package}\t${Priority}\n' | awk '/important$/ {printf "%s ", $1}')
# Install packages with priority 'standard'
apt-get install $(dpkg-query -W -f'${Package}\t${Priority}\n' | awk '/standard$/ {printf "%s ", $1}')
