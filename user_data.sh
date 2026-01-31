#!/bin/bash
sudo su
yum update
yum install -y docker
service docker start
user mod -a -G docker ec2-user