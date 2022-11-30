---
layout: post
title: Firewall Allow MySQL Remote Access (RHEL)
modified: 2022-11-7T20:00:28+07:00
categories:
description: "Firewall Allow MySQL Remote Access (RHEL)"
tags: [firewall, mysql]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-7T17:00:28+07:00
---

## Firewall Allow MySQL Remote Access (RHEL)
Prerequisites
- firewalld
- sudo privileges

Izinkan Akses MySQL Remote dengan Firewald

Step 1. Buat Sebuah Zona.

firewall-cmd --new-zone=mysql-access --permanent

Step 2. Untuk menerapkan perubahan, reload ulang firewalld.

firewall-cmd --reload

Jika Anda ingin memeriksa ulang dan membuat daftar zona firewalld, jalankan:

firewall-cmd --get-zones

Step 3. Pertama tambahkan alamat IP yang ingin Anda izinkan.

firewall-cmd --zone=mysql-access --add-source=96.52.17.9/32 --permanent

Step 4. Saya akan menambahkan port default MySQL 3306. Jika Anda menggunakan port kustom Anda sendiri, ubahlah di pengaturan.

firewall-cmd --zone=mysql-access --add-port=3306/tcp  --permanent

Step 5. Muat ulang firewall untuk menerapkan perubahan baru.

firewall-cmd --reload

Step 6. Untuk memastikan zona akses mysql dikonfigurasi dengan benar, jalankan:

firewall-cmd --zone=mysql-access --list-all

Output:

mysql-access (active)
  target: default
  icmp-block-inversion: no
  interfaces:
  sources: 96.52.17.9/32
  services:
  ports: 3306/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

Sekarang Anda harus dapat membuat koneksi antara server MySQL Anda dan mesin Anda.
Kesimpulan

Jika Anda memerlukan beberapa aturan khusus untuk diaktifkan atau dinonaktifkan terkait MySQL bisa di konfigurasi dengan firewalld.