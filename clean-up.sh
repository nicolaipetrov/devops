#!/bin/bash

echo ' cleaning: Apt-cache.'
sudo apt-get clean
echo ' cleaning: "zero out" the drive'
sudo dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
sudo rm -f /EMPTY
echo ' cleaning: history'
cat /dev/null > ~/.bash_history 
history -c
echo ' Done.'
exit