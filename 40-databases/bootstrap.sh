#!/bin/bash


COMPONENT=$1
ENV=$2

dnf install ansible -y

cd /home/ec2-user

git clone https://github.com/maheshbabu22neeli/terraform-ansible-roles-roboshop.git

cd terraform-ansible-roles-roboshop

git pull

ansible-playbook -e component=$COMPONENT -e ENV=$ENV ansible-roles-roboshop.yaml