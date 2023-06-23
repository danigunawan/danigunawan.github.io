---
layout: post
title: Proyek - DGMon Service Monitoring Platform
modified: 2023-06-23T17:00:28+07:00
categories:
description: "Proyek - DGMon Service Monitoring Platform"
tags: [dgmon, project]
image:
  background: triangular.png
comments: true
share: true
published: false
date: 2023-06-23T17:00:28+07:00
---

Proyek - DGMon Service Monitoring Platform

DGMon adalah sebuah platform yang memungkinkan Anda untuk dengan mudah memonitor status dan kesehatan/healthchecks server Linux dan Windows, APIs, website, layanan, daftar hitam (blacklist) IP, dan lainnya. Dapat disesuaikan dan notifikasi yang dapat diandalkan akan menjaga Anda tetap up-to-date dengan status dari semua monitor yang Anda miliki.

Fitur utama dari DGMon meliputi:

1. <b> Dashboard:</b> Menampilkan gambaran dari semua aset yang dimonitor beserta insiden yang terbuka.
1. <b>Server Monitoring:</b> Memudahkan pemantauan metrik-metrik server Linux dan Windows seperti penggunaan CPU, disk, RAM, jaringan, dan lainnya dengan menggunakan agent DGMon yang dapat diinstal hanya dengan satu baris perintah.
1. <b>Website Monitoring:</b> Memantau website Anda untuk mengetahui apakah website tersebut down atau loading lambat.
1. <b>Service Monitoring:</b> Memantau status dari layanan TCP atau UDP (seperti FTP, SMTP, HTTP, dll.) dengan menggunakan pemeriksaan (checks). Selain itu, Anda juga dapat menguji apakah alamat IP server Anda terdaftar dalam daftar hitam atau apakah server DNS Anda tidak berfungsi dengan baik.
1. <b>Alert dan Insiden:</b> Notifikasi yang sangat dapat disesuaikan tersedia untuk semua pemeriksaan (checks) dan metrik. Jika ada alert yang terpicu, sebuah insiden akan dibuat dan Anda akan segera mendapatkan pemberitahuan. Insiden akan ditutup secara otomatis jika masalahnya teratasi sendiri.
1. <b>Notifikasi:</b> Menerima pemberitahuan melalui email, pesan SMS, Pushbullet, Pushover, atau pesan langsung dari Twitter.
1. <b>Halaman Publik:</b> Menggunakan halaman publik untuk menampilkan status jaringan Anda tanpa perlu otentikasi.
1. <b>Pengguna dan Peran Ganda:</b> Mendukung akun pengguna dan peran ganda.
1. <b>Dukungan Multi Bahasa:</b> Sistem ini dapat dengan mudah diterjemahkan ke bahasa apa pun.
1. <b>Dapat Disesuaikan dan Responsif:</b> Beberapa skema warna dan tata letak yang dapat dipilih. DGMon sepenuhnya responsif.
1. <b> Instalasi: </b> Instalasi Cepat dan Mudah, dukungan Gravatar, dan banyak fitur lainnya.

Untuk menjalankan DGMon, server hosting Anda harus mendukung persyaratan berikut:

    Versi PHP 7.3 atau lebih baru.
    Versi MySQL 5.x atau lebih besar (disarankan MariaDB 10 untuk kinerja terbaik).
    Ekstensi PHP PDO MySQL.
    Pengaturan PHP FSOCKOPEN diaktifkan.
    Pengaturan PHP EXEC diaktifkan (opsional untuk pemeriksaan ping).
    Cronjobs.

CHANGELOG: 
1. Version 1.0 (23 Juni, 2023)
* development