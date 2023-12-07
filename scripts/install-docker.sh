#!/usr/bin/env bash

install_docker_ubuntu() {
  # Copied from : https://docs.docker.com/engine/install/ubuntu/
  #sudo apt-get remove -y docker docker-engine docker.io containerd runc
  for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove -y $pkg; done

  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

  #curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  #echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update
  #sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  sudo service docker start
}

install_docker_fedora() {
  # Copied from: https://docs.docker.com/engine/install/fedora/
  sudo dnf remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
  sudo dnf -y install dnf-plugins-core

  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

  #sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose
  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo systemctl enable docker.service
  sudo systemctl enable containerd.service
  sudo systemctl start docker
}

install_docker_macos() {
  curl https://desktop.docker.com/mac/stable/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-amd64 -O ~/Downloads/Docker.dmg
  hdiutil attach ~/Downloads/Docker.dmg
  echo "Install the Docker from the new Drive that is on the Desktop..."
  read -p "Press enter to continue... "
}

case "$OSTYPE" in
  linux-gnu)
    osname="$(grep '^ID=' /etc/os-release | cut -d'=' -f2)"
    case "$osname" in
      fedora) install_docker_fedora ;;
      ubuntu) install_docker_ubuntu ;;
      *) echo "We currently do not support your OS" ;;
    esac
    ;;
  darwun*) install_docker_macos ;;
  *) echo "We currently do not support your OS" ;;
esac