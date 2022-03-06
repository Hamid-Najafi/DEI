#!/bin/bash

echo "--------------------------"
echo "Disable Ubuntu Automatic Update"
echo "--------------------------"
sed -i 's/Prompt=lts/Prompt=never/g' /etc/update-manager/release-upgrades

# echo "--------------------------"
# echo "Setting Proxy"
# echo "--------------------------"
# use any HTTP or DNS Proxy, its required to install Package and apps like Docker
# shecan.ir
echo "--------------------------"
echo "Setting APT Sources List"
echo "--------------------------"
mv /etc/apt/sources.list /etc/apt/sources.list-back
cat > /etc/apt/sources.list <<EOF
deb http://a.docker-registry.ir/ubuntu/ $(lsb_release -cs) main restricted universe multiverse
deb-src http://a.docker-registry.ir/ubuntu/ $(lsb_release -cs) main restricted  universe multiverse
deb http://a.docker-registry.ir/ubuntu/ $(lsb_release -cs)-updates main restricted universe multiverse
deb-src http://a.docker-registry.ir/ubuntu/ $(lsb_release -cs)-updates main restricted universe multiverse
deb http://a.docker-registry.ir/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse
deb-src http://a.docker-registry.ir/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse
deb http://a.docker-registry.ir/ubuntu/ $(lsb_release -cs)-security main restricted universe multiverse
deb-src http://a.docker-registry.ir/ubuntu/ $(lsb_release -cs)-security main restricted universe multiverse
EOF

echo "--------------------------"
echo "Installing Usefull apps"
echo "--------------------------"
sudo apt update
sudo apt install -y bmon ncdu

echo "--------------------------"
echo "Setting Docker Proxy"
echo "--------------------------"
# set HTTP Proxy for docker

echo "--------------------------"
echo "Setting APT Proxy"
echo "--------------------------"
# set HTTP Proxy for APT
