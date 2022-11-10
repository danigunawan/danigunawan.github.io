---
layout: post
title: Belajar Vagrant - Part 1
description: "Belajar Vagrant - Part 1"
tags: [vagrant, hashicorp, virtualbox]
image:
  background: triangular.png
---

## Apa Itu Vagrant ?

<div style="text-align: justify">
Jika VirtuaBox adalah tools / perangkat virtualisasi untuk menginstall sistem operasi (OS) maka Vagrant (by HashiCorp) adalah produk perangkat lunak opensource untuk membantu virtualisasi (VBOX) untuk membangun, memelihara dan mengembangkan environment development aplikasi secara virtual. Adapun environment virtualisasi yang disupport vagrant selain VirtualBox yaitu KVM, Hyper-V, Docker, Kubernetes, VMware, dan AWS. 

Vagrant ini bertujuan menyederhanakan, mengautomasi manajemen konfigurasi perangkat lunak virtualisasi untuk meningkatkan produktivitas para pengembang aplikasi.
</div>

<div style="text-align: justify">
Prasarat yang dibutuhkan untuk menjalankan Vagrant adalah sebagai berikut 

OS & Tools (Prerequisite): 

* - Vagrant 
* - VirtualBox
* - OS Ubuntu 18.04 Bionic atau LTS dan CentOS 7
</div>

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

{% endhighlight %}

{% highlight bash %} 

## Install VirtualBox 7.0.2 + Vagrant 2.3.2 di CentOS 7 (RHEL 7)

# Membuat User Deploy
sudo -s 
sudo adduser deploy
sudo usermod -aG sudo deploy
passwd deploy 
su deploy

# Install dependencies
wget https://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo -P /etc/yum.repos.d/
rpm --import https://www.virtualbox.org/download/oracle_vbox.asc
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum update --skip-broken
sudo yum -y install gcc make patch dkms qt libgomp epel-release yum-utils kernel-headers kernel-devel fontforge binutils glibc-headers glibc-devel

# Install VirtualBox
sudo yum install VirtualBox-7.0
sudo systemctl status vboxdrv

# Jika Anda mendapatkan kesalahan berikut selama instalasi Virtualbox, itu berarti ada konflik antara dua versi Kernel.

"This system is currently not set up to build kernel modules.
Please install the Linux kernel "header" files matching the current kernel"

# pertama untuk resolving dengan mengecek kernel yang terinstall dan kemudian di update 

ls /usr/src/kernels/
uname -r

yum update kernel-*

reboot

# Setelah sistem selesai dengan boot, masuk dan sekali lagi konfirmasikan bahwa versi kernel-devel sekarang cocok dengan versi kernel Linux.

rpm -q kernel-devel
uname -r

# Kem#udian, mulai ulang proses pengaturan build dan konfirmasikan bahwa instalasi VirtualBox Anda berhasil dengan menjalankan:

/sbin/vboxconfig

# Check Versi VirtualBox
sudo vboxmanage --version
5.1.38r122592
7.0.2r154219

# Installing VirtualBox Extension Pack
VB_VERSION=7.0.2
VB_VERSION_PACK=$(vboxmanage --version)
sudo wget https://download.virtualbox.org/virtualbox/$VB_VERSION/Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack

sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack

# Check Extpacks Yang Sudah Di Install
sudo vboxmanage list extpacks

# Install Vagrant
LTS : 
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install vagrant


# Versi Spesifik

# cek kernel arsitektur 
uname -r

[x86_64]
sudo yum -y install https://releases.hashicorp.com/vagrant/2.3.2/vagrant-2.3.2-1.x86_64.rpm

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
    config.vm.box = "gusztavvargadr/windows-10"
    config.vm.guest = :windows
    config.vm.communicator = "winrm"
    # 3389 RDP
    config.vm.network "forwarded_port", guest: 3389, host: 3389
end

# Custom Path Vagrant Home 

# Refferensi Environment : https://www.vagrantup.com/docs/other/environmental-variables

# secara default vagrant home berada di ~/.vagrant.d namun bisa kita custom pathnya in case mungkin bisa membantu 

# jika partisi hardisk sudah mulai menipis bisa kita pindah atau pada awal kita set custom default pathnya ketempat direktori lain misalkan :

cd /home/deploy/vagrant
mkdir data 
export VAGRANT_HOME=/home/deploy/vagrant/data 

# atau 

via edit nano ~/.bashrc 

# tambahkan 
export VAGRANT_HOME=/home/deploy/vagrant/data
source ~/.bashrc 

vagrant up

==> default: Forwarding ports...
    default: 3389 (guest) => 3389 (host) (adapter 1)
    default: 5985 (guest) => 55985 (host) (adapter 1)
    default: 5986 (guest) => 55986 (host) (adapter 1)
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Mounting shared folders...
    default: /vagrant => /Users/XXX/nng.NETCore

# Vagrant RDP Password : vagrant/vagrant 
# Vagrant SSH Password : vagrant ssh atau menggunakan keys ssh yang di generate dengan ssh-keygen

# Perintah CLIs Lainnya :  
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

# Karena win 10 jalan via headless, headless disini Vbox berjalan tanpa GUI maka bisa menggunakan via Client RDP/RDP Viewer

# MacOSX :
# Microsoft Remote Desktop (ada di appstore) 

# - tinggal masukin host ip target rdp / server nya jika vagrant dan vbox jalan di laptop sendiri gunakan localhost port default rdp windows (3389)

# jika via SSH local port forward : 
ssh -N username@IP -p 22 -L localhost:3389:localhost:3389

# RDP Ke VM dengan xfreerdp dan sesuaikan resolusi layar sesuai kebutuhan:
netstat -plnt|grep 3389
tcp    0    0 0.0.0.0:33389    0.0.0.0:*    LISTEN    -

xfreerdp /v:127.0.0.1:33389 /u:vagrant /p:vagrant /smart-sizing:2000x1500

## Instal PHPVirtualBox untuk VirtualBox 70 CentOS 7

soon 

{% endhighlight %}

## Troubleshooting

{% highlight bash %} 

# 1. Vagrant failed to initialize at a very early stage:
# The home directory you specified is not accessible. The home
# directory that Vagrant uses must be both readable and writable.

# Solusi : 
sudo chown -R <user> <directory>
sudo chown -R deploy /home/deploy/vagrant/data

cd /home/deploy/vagrant/apps/win10
vagrant up

# 2. Jika Anda mendapatkan pesan kesalahan seperti KERN_DIR atau jika direktori sumber kernel Anda tidak terdeteksi secara otomatis oleh proses pembuatan, Anda dapat mengaturnya dengan menggunakan perintah berikut. Pastikan Anda mengubah versi kernel sesuai dengan sistem Anda seperti yang ditunjukkan dalam warna merah.

KERN_DIR=/usr/src/kernels/$(uname -r) # /usr/src/kernels/4.19.0-1.el7.elrepo.x86_64
export KERN_DIR

# 3. Uninstall VirtualBox 
# Dalam uninstall vbox terkadang agak triky jadi mesti dicoba dengan cara berikut ini jika uninstall biasa tidak berjalan,

# lihat list pid vbox yang berjalan : 

sudo ps aux | grep -i "vbox”

vbox       865  0.0  0.0 365264  7488 ?        Sl   10:46   0:00 /usr/lib/virtualbox/VBoxSVC --auto-shutdown
vbox       868  0.0  0.0 212472  6268 ?        S    10:46   0:00 /usr/lib/virtualbox/VBoxXPCOMIPCD
root      1856  0.0  0.0 112816  1004 pts/0    S+   10:50   0:00 grep --color=auto -i vbox
vbox      5453  0.0  0.1 595760 25584 ?        Sl   Nov07   0:49 /usr/lib/virtualbox/vboxwebsrv --background -H 10.10.8.149
vbox      5654  0.0  0.1 595760 25568 ?        Sl   Nov07   0:48 /usr/lib/virtualbox/vboxwebsrv --background -H 10.10.8.149 -p 18083
vbox      9617  0.0  0.0 522208  7136 ?        Sl   Nov07   0:02 /usr/lib/virtualbox/vboxwebsrv --background -H 0.0.0.0 -p 18083
vbox      9682  0.0  0.0 522208  7160 ?        Sl   Nov07   0:02 /usr/lib/virtualbox/vboxwebsrv --background -H 0.0.0.0 -p 18083
vbox     13241  0.0  0.0 522208  7164 ?        Sl   Nov07   0:02 /usr/lib/virtualbox/vboxwebsrv --background -H 0.0.0.0 -p 18083
vbox     26029  0.0  0.1 595760 25568 ?        Sl   Nov07   0:49 /usr/lib/virtualbox/vboxwebsrv --background -H 0.0.0.0 -p 18083

# Lalu Kill Proses PID Vbox yang berjalan
sudo kill -9 29127 26029 13241 9682 9617 5654 5453 868 865

# Install / Hapus Vbox
yum erase VirtualBox-7.0

{% endhighlight %}
