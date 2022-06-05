#!/bin/bash
sleep 120
cd /root/
cp sample.txt .
cat sample.txt | crontab -
sudo mkfs -t ext4 /dev/xvdf
sudo mkdir /backup
sudo mount /dev/xvdf /backup
