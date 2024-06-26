FROM python:3.12.3-slim 

ENV TERRAFORM_VERSION=1.8.2

# Install Terraform
RUN apt update -y \
    && apt install -y curl unzip git \ 
    && apt autoremove -y \
    && curl -q https://releases.hashicorp.com/terraform/{$TERRAFORM_VERSION}/terraform_{$TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip -q terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm -rf terraform.zip

# Install Ansible
RUN apt install -y sshpass
RUN pip install --upgrade pip && pip install ansible proxmoxer requests

# Install task
RUN (cd /usr && curl -sL https://taskfile.dev/install.sh | sh)

WORKDIR /srv