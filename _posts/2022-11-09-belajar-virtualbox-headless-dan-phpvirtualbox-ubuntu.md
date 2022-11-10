---
layout: post
title: Belajar VirtualBox Headless dan PHPVirtualBox Ubuntu/Mint
description: "Belajar VirtualBox Headless dan PHPVirtualBox Ubuntu/Mint"
tags: [virtualbox, phpvirtualbox, headless]
image:
  background: triangular.png
---

## Apa Itu Virtualbox ?

<div style="text-align: justify">
VirtuaBox adalah tools / perangkat virtualisasi untuk menginstall sistem operasi didalamnya biasanya virtualbox digunakan sebagai alat / tools pengujian, membantu lingkungan development
</div>

Prasarat yang dibutuhkan untuk menjalankan Vagrant adalah sebagai berikut.

OS & Tools (Prerequisite): 

* VirtualBox 7.0.2
* PHPVirtualBox
* OS Ubuntu 18.04 Bionic

## Install VirtualBox 7.0.2 + PHPVirtualBox di Ubuntu 18.04 Bionic
{% highlight bash %} 
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

sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack

vboxmanage list extpacks

# membuat user vboxadmin
sudo useradd vboxadmin

# set vboxadmin password
sudo passwd vboxadmin # password

# tambahkan vboxadmin kedalam group vboxuser
sudo usermod -aG vboxusers vboxadmin

# membuat direktori vboxadmin di path home
sudo mkdir /home/vboxadmin -p

# membuat pengaturan akses owner path vboxadmin sebagai owner di home direktori
sudo chown -R vboxadmin /home/vboxadmin

# edit dan tambahkan konfigurasi default virtualbox 
sudo nano /etc/default/virtualbox

VBOXWEB_USER=vboxadmin
#VBOXWEB_PASSWD=[the password you set when you created the vbox user]
VBOXWEB_HOST=10.48.102.238
#VBOXWEB_PORT=18083 # default 18083
#VBOXWEB_TIMEOUT=
#VBOXWEB_CHECK_INTERVAL=
#VBOXWEB_THREADS=
#VBOXWEB_KEEPALIVE=
VBOXWEB_LOGFILE=/home/vboxadmin/.config/VirtualBox/vboxweb-service.log
#INSTALL_DIR=

# lalu save

# membuat vboxweb.sh
sudo nano /home/vboxadmin/vboxweb.sh

#!/bin/bash
/usr/bin/vboxwebsrv -H 10.48.102.238 > /dev/null 2>&1

# ubah vboxweb.sh menjadi agar bisa di eksekusi
sudo chmod +x /home/vboxadmin/vboxweb.sh

# membuat servis phpvirtualbox.service
sudo nano /etc/systemd/system/phpvirtualbox.service

# dan simpan seperti konfigurasi dibawah ini
[Unit]
Description=VirtualBox Web Service
After=network.target
[Service]
Type=simple
RemainAfterExit=yes
User=vboxadmin
Group=vboxusers
WorkingDirectory=/home/vboxadmin
ExecStart=/home/vboxadmin/vboxweb.sh
Restart=on-failure
[Install]
WantedBy=default.target

# Aktifkan phpvirtualbox.service
sudo systemctl enable phpvirtualbox.service

# Jalankan phpvirtualbox.service
 sudo systemctl start phpvirtualbox.service

# Install Skrip PHPVirtualBox (Via Docker)
Struktur Code :
- config.php (berisikan konfigurasi phpvirtualbox)
- Dockerfile (file konfigurasi builder images docker)
- nginx.conf (konfigrasi web phpvirtualbox dan reverse proxy nya)
- servers-from-env.php (konfigurasi untuk environment autoload untuk phpvirtualbox)
- Makefile (untuk shortcut pengembangan)

# Langkah Pertama Build Images 
docker build --no-cache -f Dockerfile -t phpvirtualbox6x .

# Jalankan PHPVirtualBox dengan Docker yang sudah dibuild
docker run --name vbox_http --restart=always -p 8149:80 \
        -e SRV1_HOSTPORT=172.17.0.1:18083 -e SRV1_NAME=ServerVBOX -e SRV1_USER=vbox -e SRV1_PW='password' \
        -d phpvirtualbox6x

* -p 8149:80 : port yang diekspose dari docker (80) dari container kita expose ke luar dengan menggunakan port alias 8149 (mirip seperti metode forwarding pada port/NAT)
* --name vbox_http : argument docker untuk menset nama container 
* --restart=always : container dijalankan dan diset default dengan konfigurasi restart always jadi jika servis mati bisa hidup lagi
* -d : docker dijalankan secara background
* phpvirtualbox6x : nama images phpvirtualbox yang kita build tadi
* ENV SRV1_HOSTPORT : Merupakan Host Server VirtualBox melalui servis vboxweb yang berjalan di port 18083 (yang membantu untuk dikonfigurasi melalui phpvirtualbox) disini kita bisa set dengan any host (0.0.0.0) atau pakai IP GW Docker 172.17.0.1
* ENV SRV1_NAME: Nama server Vbox kita set ServerVBOX
* ENV SRV1_USER: username vboxweb yang digunakan phpvirtualbox
* ENV SRV1_PW: Passowrd vboxweb yang digunakan phpvirtualbox

{% endhighlight %}