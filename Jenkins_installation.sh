#!/bin/bash

# Starting Script
echo "Running Shell Script"

# Updating server
echo "Updating packages"
sudo apt-get update

# Installing Docker
if ! command -v docker &> /dev/null
then
    echo "Installing Docker"
    sudo apt-get install docker.io -y
else
    echo "Docker already installed"
fi

# Installing Java (OpenJDK 17)
echo "Checking Java installation"
if ! java -version &> /dev/null
then
    echo "Installing Java version 17"
    sudo apt install fontconfig openjdk-17-jre -y
else
    echo "Java already installed"
fi

# Acquiring Jenkins keys and repo
echo "Adding Jenkins repo and key"
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list after adding Jenkins repo
echo "Updating packages after adding Jenkins repo"
sudo apt-get update

# Installing Jenkins
if ! dpkg -l | grep -q jenkins
then
    echo "Installing Jenkins"
    sudo apt-get install jenkins -y
else
    echo "Jenkins already installed"
fi

echo "Jenkins successfully installed!"
