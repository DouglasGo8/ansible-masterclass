#!/bin/bash
set -e

# 1. System Updates and Tools
dnf update -y
dnf install -y python3 python3-pip openssh-server openssh-clients git curl wget

# 2. Instalação do Podman (Obrigatório para o Navigator usar Execution Environments)
dnf install -y podman

# 3. Ansible Core e Navigator
dnf install -y ansible-core
# Instalamos o navigator para o usuário ec2-user para evitar conflitos de permissão
runuser -l ec2-user -c "pip3 install ansible-navigator --user"

# 4. Ajustes de Ambiente (PATH e Aliases)
echo "alias ansible=/usr/bin/ansible" >> /home/ec2-user/.bashrc
echo 'export PATH=$PATH:~/.local/bin' >> /home/ec2-user/.bashrc
chown ec2-user:ec2-user /home/ec2-user/.bashrc

# 5. Configuração SSH e Diretórios
systemctl enable sshd --now
runuser -l ec2-user -c "mkdir -p ~/ansible"

# 6. Geração do Log de Auditoria (O que você pediu)
LOG_OUT="/var/log/setup_output.txt"
{
  echo "--- Ansible Control Node Setup Report ---"
  echo "Timestamp: $(date)"
  echo "-----------------------------------------"
  echo "Podman Version: $(podman --version)"
  echo "Ansible Core: $(ansible --version | head -n 1)"
  echo "Navigator: $(runuser -l ec2-user -c 'ansible-navigator --version')"
  echo "-----------------------------------------"
} > $LOG_OUT

cp $LOG_OUT /var/log/setup.log