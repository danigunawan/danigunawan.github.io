---
layout: post
title: Belajar Vagrant - Part 1
description: "Belajar Vagrant - Part 1"
tags: [blog, jekyll hpstr, github pages]
image:
  background: triangular.png
---

OS & Tools : 
- Vagrant 
- VirtualBox
- OS Ubuntu 18.04 Bionic atau LTS


## Install VirtualBox 7.0.2 + Vagrant 2.3.2 di Ubuntu 18.04 Bionic


{% highlight bash %} 

#!/bin/bash

#Installing VirtualBox
sudo apt update
sudo apt -y install build-essential dkms unzip wget libarchive-tools curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates
echo "deb [arch=$(dpkg --print-architecture)] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee -a /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt update
sudo apt -y install virtualbox-7.0
sudo systemctl status vboxdrv

#Installing VirtualBox Extension Pack
VB_VERSION=$(dpkg-query --showformat='${Version}' --show virtualbox-7.0 | awk -F'-' '{print $1}')
wget https://download.virtualbox.org/virtualbox/$VB_VERSION/Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack

sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack --accept-license=33d7284dc4a0ece381196fda3cfe2ed0e1e8e7ed7f27b9a9ebc4ee22e24bd23c


#Installing Vagrant
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"


Vagrant LTS :
sudo apt-get update && sudo apt-get install vagrant

Versi Spesifik :

curl -O https://releases.hashicorp.com/vagrant/2.3.2/vagrant_2.3.2_linux_amd64.zip


cek jenis arsitektur OS :
dpkg --print-architecture

pilih instalasi sesuai arsitektur 

[AMD64]

unzip vagrant_2.3.2_linux_amd64.zip
mv vagrant /usr/local/bin/

[X86_64]

sudo dpkg [your_deb_packages_files]

[I686]

install konversi file .rpm ke .deb packages :
sudo alien <name of package>.rpm
sudo dpkg -i <name of package>.deb

install langsung :
sudo alien -i <name of package>.rpm

#Cek Versi Vagrant
vagrant --version

# Test & Mulai Project Vagrant
mkdir ~/test-vagrant
cd ~/test-vagrant

vagrant box add gusztavvargadr/boxes/windows-10 
vagrant init centos/7
vagrant up
vagrant ssh
vagrant halt
vagrant destroy

{% endhighlight %}