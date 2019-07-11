#!/bin/bash

# Credits to:
#  - http://vstone.eu/reducing-vagrant-box-size/
#  - https://github.com/mitchellh/vagrant/issues/343

# Remove APT cache
echo -n "Remove APT cache.. "
apt-get clean -y
apt-get autoclean -y
echo "Remove APT cache..  Done. "

# Remove bash history
echo -n " Wipe-out bash history .. "
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history
echo " Done "

# Cleanup log files
echo -n " Wipe-outlog files .. "
find /var/log -type f | while read f; do echo -ne '' > $f; done;
echo " Done "

# Whiteout root
echo -n " Whiteout root .. "
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`; 
let count--
dd if=/dev/zero of=/whitespace bs=1024 count=$count;
rm /whitespace;
echo " Done "

# Whiteout tmp
echo -n " Whiteout tmp .. "
count=`df --sync -kP /tmp | tail -n1  | awk -F ' ' '{print $4}'`; 
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;
echo " Done "

# Whiteout /boot
echo -n " Whiteout Boot .. "
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;
echo " Done "

# Whiteout Swap
echo -n " Whiteout SWAP .. "
swappart=$(cat /proc/swaps | grep -v Filename | tail -n1 | awk -F ' ' '{print $1}')
if [ "$swappart" != "" ]; then
  swapoff $swappart;
  dd if=/dev/zero of=$swappart;
  mkswap $swappart;
  swapon $swappart;
fi
echo " Done "
echo "All steps - Done !"
