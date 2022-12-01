---
layout: post
title: Install Anydesk Linux
modified: 2022-11-9T20:00:28+07:00
categories:
description: "Install Anydesk Linux"
tags: [vagrant, hashicorp, virtualbox]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-9T19:00:28+07:00
---
Anydesk merupakan aplikasi untuk kebutuhan remote desktop sejenis dengan tightVNC dan VNC Server lainnya namun Anydesk ini sangat fungsional, manageable, beragam fitur dan sekelas aplikasi remote desktop dengan frame buffer yang cepat.

Run the following commands as root user:
sudo -s 

- add repository key to Trusted software providers list

wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -

- add the repository:

echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list

- update apt cache:

apt update

- install anydesk:

apt install anydesk

- anydesk ID
anydesk --get-id

- anydesk set password 
echo your_password | anydesk --set-password

Refferences : 
http://deb.anydesk.com/howto.html