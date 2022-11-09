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
# Membuat User Deploy
sudo -s 
sudo adduser deploy
sudo usermod -aG sudo deploy
passwd deploy 
su deploy

# Installing VirtualBox
sudo apt update
sudo apt -y install build-essential dkms unzip wget libarchive-tools curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates
echo "deb [arch=$(dpkg --print-architecture)] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee -a /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt update
sudo apt -y install virtualbox-7.0
sudo systemctl status vboxdrv

# Installing VirtualBox Extension Pack
VB_VERSION=$(dpkg-query --showformat='${Version}' --show virtualbox-7.0 | awk -F'-' '{print $1}')
wget https://download.virtualbox.org/virtualbox/$VB_VERSION/Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack

sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack --accept-license=33d7284dc4a0ece381196fda3cfe2ed0e1e8e7ed7f27b9a9ebc4ee22e24bd23c

vboxmanage list extpacks


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

vagrant box add gusztavvargadr/boxes/windows-10 --insecure
or
vagrant init gusztavvargadr/boxes/windows-10 
vagrant up
vagrant ssh
vagrant rdp
vagrant halt
vagrant destroy

# Uninstall Vagrant 
rm -rf /opt/vagrant
rm -f /usr/bin/vagrant


## Install VirtualBox VirtualBox-5.1-5.1.38 + Vagrant 2.3.2 di CentOS 7

# Membuat User Deploy
sudo -s 
sudo adduser deploy
sudo usermod -aG sudo deploy
passwd deploy 
su deploy

# Install dependencies
sudo yum update --skip-broken
sudo yum -y install gcc make patch dkms qt libgomp epel-release yum-utils kernel-headers kernel-devel fontforge binutils glibc-headers glibc-devel

# Install VirtualBox
cd /etc/yum.repos.d
sudo wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
sudo yum install VirtualBox-5.1

sudo systemctl status vboxdrv

# Check Versi VirtualBox
sudo vboxmanage --version
5.1.38r122592

#Installing VirtualBox Extension Pack
VB_VERSION=5.1.38
VB_VERSION_PACK=$(vboxmanage --version)
sudo wget https://download.virtualbox.org/virtualbox/$VB_VERSION/Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack

sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack --accept-license=33d7284dc4a0ece381196fda3cfe2ed0e1e8e7ed7f27b9a9ebc4ee22e24bd23c

sudo vboxmanage list extpacks

# Periksa apakah Anda memiliki sumber kernel yang diunduh untuk versi kernel Anda yang sedang berjalan (jika tidak cocok, Anda mungkin perlu memperbarui dan mem-boot ulang yum)
ls /usr/src/kernels/
uname -r

# Bangun modul kernel VirtualBox
export KERN_DIR=/usr/src/kernels/$(uname -r)
/sbin/rcvboxdrv setup

# Install Vagrant
LTS : 
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install vagrant


#Versi Spesifik
#cek kernel arsitektur 
uname -r

[x86_64]
sudo yum -y install https://releases.hashicorp.com/vagrant/1.9.7/vagrant_1.9.7_x86_64.rpm

vagrant --version

# Test Vagrant
cd /home/deploy
mkdir win10 
cd win10
sudo vagrant box add gusztavvargadr/boxes/windows-10 --insecure
sudo vagrant box list # gusztavvargadr/windows-10
sudo vagrant init gusztavvargadr/windows-10

# Vagrant Windows 10 RDP 
Vagrantfile :

Vagrant.configure("2") do |config|
    config.vm.box = "win10_ltsc_2019"
    config.vm.guest = :windows
    config.vm.communicator = "winrm"
    # 3389 RDP
    config.vm.network "forwarded_port", guest: 3389, host: 3389
end

vagrant up

==> default: Forwarding ports...
    default: 3389 (guest) => 3389 (host) (adapter 1)
    default: 5985 (guest) => 55985 (host) (adapter 1)
    default: 5986 (guest) => 55986 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Mounting shared folders...
    default: /vagrant => /Users/XXX/nng.NETCore

Vagrant RDP Password : vagrant/vagrant 
Vagrant SSH Password : vagrant ssh atau menggunakan keys ssh yang di generate dengan ssh-keygen

Perintah CLIs Lainnya :  
vagrant ssh
vagrant rdp
vagrant halt
vagrant destroy
vagrant box list

# Uninstall Vagrant 
sudo yum erase vagrant 
rm -rf /opt/vagrant
rm -f /usr/bin/vagrant

# Jika Vagrant dan Vbox jalan via GUI Bukan Headless 
vagrant rdp
==> default: Detecting RDP info...
    default: Address: 127.0.0.1:3389
    default: Username: vagrant

# Client Win 10 RDP (Headless)
Karena win 10 jalan di via headless di Vbox tanpa GUI maka via Client RDP/RDP Viewer

MacOSX :
Microsoft Remote Desktop (ada di appstore) 
- tinggal masukin host ip target rdp / server nya jika vagrant dan vbox jalan di laptop sendiri gunakan localhost 
jika via SSH local port forward : ssh -N username@IP -p 22 -L localhost:3389:localhost:3389

## Instal PHPVirtualBox untuk VirtualBox 5.1 CentOS 7


{% endhighlight %}