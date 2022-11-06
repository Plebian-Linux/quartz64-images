#!/bin/sh

# Taken from mobian-recipes, modified for Plebian

# Remove apt packages which are no longer unnecessary and delete
# downloaded packages
apt -y autoremove --purge
apt clean

# Remove SSH keys and machine ID so they get generated on first boot
# also the random seed and credentials.secret
rm -f /etc/ssh/ssh_host_* \
      /etc/machine-id \
      /var/lib/dbus/machine-id \
      /var/lib/systemd/random-seed \
      /var/lib/systemd/credential.secret
