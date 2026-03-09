#!/bin/bash
sudo su
yum update
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
yum install -y docker
service docker start
usermod -a -G docker ec2-user
