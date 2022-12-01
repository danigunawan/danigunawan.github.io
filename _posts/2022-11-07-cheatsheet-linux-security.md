---
layout: post
title: Kumpulan Cheatsheet Linux Security
modified: 2022-11-7T20:00:28+07:00
categories:
description: "Kumpulan Cheatsheet Linux Security"
tags: [cheatsheet, cheatsheet linux]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-7T17:00:28+07:00
---

## Kumpulan Cheatsheet Linux Security Firewall

* Linux Iptables Memblokir Semua Lalu Lintas Masuk Kecuali SSH

Ini adalah skenario yang tersebar luas. ingin mengizinkan akses remote machine hanya dengan SSH di TCP port 22. memblokir semua lalu lintas yang masuk ke sistem kecuali koneksi ssh di Linux.

disini menjelaskan cara memblokir semua lalu lintas IPv4 dan IPv6 yang masuk tetapi mengizinkan lalu lintas menggunakan perintah iptables untuk SSH TCP port 22.

Sintaksnya adalah sebagai berikut untuk firewall IPv4:
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT

Untuk IPv6 coba:
/sbin/ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT

Kemudian Anda menyimpan aturan iptables dengan menjalankan perintah berikut:
iptables-save > /path/to/iptables.save.conf
iptables-save > /etc/sysconfig/iptables
ip6tables-save > /etc/sysconfig/ip6tables

Memblokir semua lalu lintas kecuali pada port TCP 22

ingin memiliki skrip shell khusus untuk firewall? Kemudian tambahkan aturan berikut ke skrip shell iptables:

/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
/sbin/iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

Aturan pertama akan menerima koneksi tcp masuk (INPUT) pada port 22 (server ssh) dan aturan kedua akan mengirimkan respons server ssh yang masuk ke klien (OUTPUT) dari port sumber server ssh 22.

Contoh skrip shell

Namun, iptables dengan kernel 2.4/2.6/3.x/4.x/5.x menyediakan fasilitas yang sangat kuat untuk memfilter aturan berdasarkan status koneksi yang berbeda seperti koneksi yang dibuat atau koneksi baru, dll. Berikut ini skrip kecil lengkap untuk melakukan tugas ini:

{% highlight bash %} 
#!/bin/sh
# Purpose: Linux Iptables Block All Incoming Traffic But Allow SSH @ TCP/22
# AUTHOR: Vivek Gite {www.cyberciti.biz}
# -------------------------------------------------------------------------------------
# My system IP/set ip address of server here
SERVER_IP="65.55.12.13"
 
# Flushing all rules
iptables -F
iptables -X
 
# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
 
# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
 
# Allow incoming ssh only
iptables -A INPUT -p tcp -s 0/0 -d $SERVER_IP --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s $SERVER_IP -d 0/0 --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT
 
# make sure nothing comes or goes out of this box
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP

{% endhighlight %}

Skrip ini murni firewall yang strict/ketat. Itu memungkinkan ssh masuk. Tidak ada layanan masuk atau permintaan ping lainnya atau tidak ada layanan atau permintaan keluar yang diizinkan. Koneksi ssh yang masuk bisa baru atau sudah ada dan itulah yang ditentukan oleh aturan status '-m state –state NEW, ESTABLISHED'. 

Status koneksi ssh keluar hanya dapat dibuat. Secara default skrip ini memungkinkan semua orang untuk ssh dengan aturan -s 0/0. Jika Anda ingin akses tersebut dibatasi oleh IP atau alamat jaringan, ganti -s 0/0 dengan alamat IP. Misalnya izinkan ssh masuk dari IP 202.54.1.20:

Allow incoming ssh only from IP 202.54.1.20

iptables -A INPUT -p tcp -s 202.54.1.20 -d $SERVER_IP --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s $SERVER_IP -d 202.54.1.20 --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT

Cara membuat daftar aturan/rules firewall

iptables -S
ip6tables -S
# Filter out tcp/22 using the grep/egrep command #
ip6tables -S | grep -i '22'
# IPv6 examples #
iptables -L -n -v
ip6tables -L -n -v

Menghapus Rules Firewall
Pertama dapatkan daftar aturan dengan nomor baris:
/sbin/iptables -L INPUT -v -n --line-numbers
/sbin/ip6tables -L INPUT -v -n --line-numbers

Kemudian hapus aturan itu. 
asumsi pada nomor 7, jadi:

/sbin/iptables -D INPUT 7
/sbin/ip6tables -D INPUT 7

Cara melihat log firewall
dmesg | more
dmesg | grep -w 'DPT=22'

Catatan tentang menjaga agar log firewall tetap terkendali
dengan penggunaan disk direktori log Linux menggunakan perintah df atau du perintah. Contohnya:
df -hT
du -chs /var/log

Outputs:

2.5G	/var/log
2.5G	total

Linux Iptables Memblokir Semua Lalu Lintas Kecuali Untuk SSH Dengan Batasan
terlalu banyak log karena iptables? dengan cara membatasi ukuran log menggunakan modul -m limit. Sebagai contoh:

# Enable log but with limits
/sbin/iptables -A INPUT -p tcp --dport 22 -m limit --limit 5/m --limit-burst 7 -j LOG --log-prefix "SSH_TCP_22_LOG: "
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT

Catatan tentang firewalld dan ufw

Pada distro Linux modern, kebanyakan akan menggunakan bagian depan firewall yang disediakan oleh perintah ufw atau perintah firewall-cmd alih-alih mengetikkan perintah iptables mentah di prompt. Lihat cara membuka port TCP 22 menggunakan ufw dan membatasi koneksi ssh di port TCP 22 menggunakan ufw.

Kesimpulan

Dan begitulah cara mengizinkan lalu lintas IPv4/IPv6 di port SSH TCP 22 tetapi memblokir yang lainnya.

manual iptables berikut menggunakan perintah:
man iptables
man ip6tables