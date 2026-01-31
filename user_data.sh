#!/bin/bash
sudo su
yum update
yum install -y docker
service docker start
usermod -a -G docker ec2-user