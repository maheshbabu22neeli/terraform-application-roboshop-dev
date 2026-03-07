#!/bin/bash

# We are creating 50GB root disk, but 20GB is for partitioned
# Remaining 30GB we need to add/extend to /home file system
growpart /dev/nvme0n1 4
lvextend -r -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform