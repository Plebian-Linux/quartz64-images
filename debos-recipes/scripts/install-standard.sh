#!/bin/sh
apt-get install $(dpkg-query -W -f'${Package}\t${Priority}\n' | awk '/important$/ {printf "%s ", $1}')
