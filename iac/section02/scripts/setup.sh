#!/bin/bash
set -e

# Update system
dnf update -y

# Python 3 Installation (Ansible mandatory req)
dnf install -y python3 python3-pip

# SSH Server Installation
dnf install -y openssh-server openssh-clients

systemctl enable sshd
systemctl start sshd

# Firewall Server Installation
dnf install -y firewalld
systemctl enable firewalld
systemctl start firewalld

# git cli installation (need to clone repos)
dnf install -y git

# curl and wget installation (basic tooling)
dnf install -y curl wget

# Ansible Core Installation
dnf install -y ansible-core

# Log all installation actions
echo "Control Node setup completed at $(date)" > /var/log/setup.log
echo "Ansible version: $(ansible --version)" >> /var/log/setup.log