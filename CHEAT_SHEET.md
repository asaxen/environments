# Cheat Sheet

## How to set up virtualenv with a certain python version

Virtual environment with python 3
```sh
which python3
mkvirtualenv --python=/usr/bin/python3 nameOfEnvironment
```

## How to install newest docker
```sh
#Prepare install of docker-ce
apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
apt-get update
apt-get upgrade
# Install the ubuntu packages
apt-get install -y docker-ce
```
