---
layout: post
title: Mengatasi Error DPKG Di Ubuntu
modified: 2023-03-30T17:00:28+07:00
categories:
description: "Mengatasi Error DPKG Di Ubuntu"
tags: [ubuntu, dpkg]
image:
  background: triangular.png
comments: true
share: true
date: 2023-03-30T17:00:28+07:00
---

Error ini biasanya terjadi pada saat menginstal aplikasi di Ubuntu.

Contoh kasus 1

    Unpacking replacement smplayer ...
    dpkg: error processing /var/cache/apt/archives/smplayer_0.6.9+svn3595-1ppa1~maverick1_i386.deb (--unpack):
    trying to overwrite '/usr/share/smplayer/translations/smplayer_eu.qm', which is also in package smplayer-translations 0.6.9-1
    dpkg-deb: subprocess paste killed by signal (Broken pipe)

Contoh kasus 2


    sudo apt-get install dockmanager
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    The following NEW packages will be installed:
    dockmanager
    0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
    Need to get 0B/94.4kB of archives.
    After this operation, 430kB of additional disk space will be used.
    (Reading database ... 162015 files and directories currently installed.)
    Unpacking dockmanager (from .../dockmanager_0.1.0~bzr83-0ubuntu1~10.10~dockers1_amd64.deb) ...
    dpkg: error processing /var/cache/apt/archives/dockmanager_0.1.0~bzr83-0ubuntu1~10.10~dockers1_amd64.deb (--unpack):
    trying to overwrite '/usr/share/dockmanager/data/skype_invisible.svg', which is also in package faenza-icon-theme 0.8
    dpkg-deb: subprocess paste killed by signal (Broken pipe)
    Errors were encountered while processing:
    /var/cache/apt/archives/dockmanager_0.1.0~bzr83-0ubuntu1~10.10~dockers1_amd64.deb
    E: Sub-process /usr/bin/dpkg returned an error code (1)

Cara Memperbaikinya

Untuk memperbaikinya (dalam banyak kasus), caranya adalah perhatikan alur jalan (path) file tersebut. Untuk kasus 1 alurnya adalah 

"/var/cache/apt/archives/smplayer_0.6.9+svn3595-1ppa1~maverick1_i386.deb" kemudian atasi dengan menjalankan perintah:

    sudo dpkg -i --force-overwrite /var/cache/apt/archives/smplayer_0.6.9+svn3595-1ppa1~maverick1_i386.deb


Bila perintah "--force-overwrite" gagal, coba gunakan "--force-all".

Perintah diatas bila alur jalan (path)-nya sama. Bila menginstall melalui repository maka file .deb ada di /var/cache/apt/archives

Perintah-perintah diatas adalah untuk mengatasi masalah bila 2 paket aplikasi menyebabkan terjadinya error. Untuk memastikan aplikasi terinstall dengan sukses, jalankan perintah:

    sudo apt-get install -f

Semoga bermanfaat, terima kasih :)