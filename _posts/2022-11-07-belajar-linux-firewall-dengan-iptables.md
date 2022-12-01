---
layout: post
title: Belajar Linux Firewall Dengan Iptables
modified: 2022-11-7T20:00:28+07:00
categories:
description: "Belajar Linux Firewall Dengan Iptables"
tags: [cheatsheet, cheatsheet linux, security, linux security]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-7T17:00:28+07:00
---

### 1.Linux Iptables Memblokir Semua Lalu Lintas Masuk Kecuali SSH

Ingin mengizinkan akses remote machine hanya dengan SSH di TCP port 22. memblokir semua lalu lintas yang masuk ke sistem kecuali koneksi ssh di Linux.

disini menjelaskan cara memblokir semua lalu lintas IPv4 dan IPv6 yang masuk tetapi mengizinkan lalu lintas menggunakan perintah iptables untuk SSH TCP port 22.

Sintaksnya adalah sebagai berikut untuk firewall IPv4:
{% highlight bash %} 
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
{% endhighlight %}


Untuk IPv6 coba:
{% highlight bash %} 
/sbin/ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT
{% endhighlight %}

Kemudian Anda menyimpan aturan iptables dengan menjalankan perintah berikut:

{% highlight bash %}
iptables-save > /path/to/iptables.save.conf
iptables-save > /etc/sysconfig/iptables
ip6tables-save > /etc/sysconfig/ip6tables
{% endhighlight %}

Bagaimana cara menyimpan iptables bisa disimak pada bab [* Bagaimana Saya Menyimpan Aturan atau Pengaturan Iptables?]

Memblokir semua lalu lintas kecuali pada port TCP 22

ingin memiliki skrip shell khusus untuk firewall? Kemudian tambahkan aturan berikut ke skrip shell iptables:
{% highlight bash %}
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
/sbin/iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
{% endhighlight %}

Aturan pertama akan menerima koneksi tcp masuk (INPUT) pada port 22 (server ssh) dan aturan kedua akan mengirimkan respons server ssh yang masuk ke klien (OUTPUT) dari port sumber server ssh 22.

Contoh skrip shell

Namun, iptables dengan kernel 2.4/2.6/3.x/4.x/5.x menyediakan fasilitas yang sangat kuat untuk memfilter aturan berdasarkan status koneksi yang berbeda seperti koneksi yang dibuat atau koneksi baru, dll. Berikut ini skrip kecil lengkap untuk melakukan tugas ini:

{% highlight bash %} 
#!/bin/sh
# Purpose: Linux Iptables Block All Incoming Traffic But Allow SSH @ TCP/22
# AUTHOR: Vivek Gite {www.danigunawan.github.io}
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

Izinkan ssh masuk hanya dari IP 202.54.1.20

{% highlight bash %}
iptables -A INPUT -p tcp -s 202.54.1.20 -d $SERVER_IP --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p tcp -s $SERVER_IP -d 202.54.1.20 --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT

{% endhighlight %}


Cara membuat daftar aturan/rules firewall
{% highlight bash %}
iptables -S
ip6tables -S
# Filter out tcp/22 using the grep/egrep command #
ip6tables -S | grep -i '22'
# IPv6 examples #
iptables -L -n -v
ip6tables -L -n -v
{% endhighlight %}

Menghapus Rules Firewall
{% highlight bash %}
 Pertama dapatkan daftar aturan dengan nomor baris:
/sbin/iptables -L INPUT -v -n --line-numbers
/sbin/ip6tables -L INPUT -v -n --line-numbers
{% endhighlight %}

Kemudian hapus aturan itu. 
asumsi pada nomor 7, jadi:

{% highlight bash %}
/sbin/iptables -D INPUT 7
/sbin/ip6tables -D INPUT 7
{% endhighlight %}

Cara melihat log firewall
{% highlight bash %}
 dmesg | more
dmesg | grep -w 'DPT=22'
{% endhighlight %}

Catatan tentang menjaga agar log firewall tetap terkendali
dengan penggunaan disk direktori log Linux menggunakan perintah df atau du perintah. Contohnya:
{% highlight bash %}
df -hT
du -chs /var/log

# Outputs:

2.5G	/var/log
2.5G	total
{% endhighlight %}


Linux Iptables Memblokir Semua Lalu Lintas Kecuali Untuk SSH Dengan Batasan
terlalu banyak log karena iptables? dengan cara membatasi ukuran log menggunakan modul -m limit. Sebagai contoh:

{% highlight bash %}

# Enable log but with limits
/sbin/iptables -A INPUT -p tcp --dport 22 -m limit --limit 5/m --limit-burst 7 -j LOG --log-prefix "SSH_TCP_22_LOG: "
/sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
{% endhighlight %}

Catatan tentang firewalld dan ufw

Pada distro Linux modern, kebanyakan akan menggunakan bagian depan firewall yang disediakan oleh perintah ufw atau perintah firewall-cmd alih-alih mengetikkan perintah iptables mentah di prompt. Lihat cara membuka port TCP 22 menggunakan ufw dan membatasi koneksi ssh di port TCP 22 menggunakan ufw.

Kesimpulan

Dan begitulah cara mengizinkan lalu lintas IPv4/IPv6 di port SSH TCP 22 tetapi memblokir yang lainnya.

manual iptables berikut menggunakan perintah:
{% highlight bash %}
man iptables
man ip6tables
{% endhighlight %}



### 2.Bagaimana Saya Menyimpan Aturan atau Pengaturan Iptables?
menggunakan alat GUI untuk mengatur aturan firewall untuk komputer server yang terhubung ke jaringan ADSL (DSL/Cable) / FO, Cloud, bahkan VPS. Namun, setelah reboot rules Iptables tidak tersimpan. 
Bagaimana cara dapat menyimpan dan memuat semua aturan firewall lagi?

Kita perlu menggunakan perintah iptables-save. Ini digunakan untuk membuang isi Tabel IP dalam format yang mudah diuraikan ke layar. Menggunakan I/O redirection yang disediakan oleh shell, kita dapat menyimpan aturan firewall iptables ke file teks. Untuk mengembalikan aturan iptables gunakan perintah iptables-restore. Ini digunakan untuk mengembalikan Tabel IP dari data yang ditentukan dari file. Gunakan I/O redirection yang disediakan oleh shell kita untuk membaca dari file.

Contoh: Menyimpan dan Merestore Aturan Iptables

Dalam contoh ini, simpan aturan firewall iptables saat ini ke file bernama /root/dsl.fw, masukkan:
{% highlight bash %}
iptables-save > /root/dsl.fw
{% endhighlight %}

Untuk mengembalikan aturan iptables, masukkan:
{% highlight bash %}
iptables-restore < /root/dsl.fw
{% endhighlight %}

Untuk memulihkan aturan secara otomatis setelah sistem Linux di-boot ulang, tambahkan perintah berikut ke file /etc/rc.local Anda, masukkan:

{% highlight bash %}
vi /etc/rc.local
{% endhighlight %}

Tambahkan baris:
{% highlight bash %}
/sbin/iptables-restore < /root/dsl.fw
{% endhighlight %}

Simpan dan tutup file dengan menekan Esc diikuti dengan :x saat menggunakan vim.
Catatan tentang RHEL/CentOS 6.x dan versi Fedora yang lebih lama

Harap perhatikan bahwa di bawah Red Hat enterprise Linux (RHEL) / CentOS / Fedora Linux Anda dapat menggunakan perintah berikut untuk menyimpan dan memulihkan aturan firewall. Untuk Menyimpan aturan ke file /etc/sysconfig/iptables:

{% highlight bash %}
/etc/init.d/iptables save
{% endhighlight %}

Untuk mengembalikan aturan dari file /etc/sysconfig/iptables:

{% highlight bash %}
/etc/init.d/iptables start
{% endhighlight %}

Cara Restore Firewall Rules Debian/Ubuntu Linux

Jika menggunakan Debian / Ubuntu Linux, buka /etc/network/interfaces:

{% highlight bash %}
vi /etc/network/interfaces
{% endhighlight %}

Tambahkan baris ke bagian eth0:
{% highlight bash %}
post-up iptables-restore </path/to/file
{% endhighlight %}

Tutup dan simpan file. Reboot ulang sistem.

Mengaktifkan dukungan /etc/rc.local dengan distro Linux berbasis systemd

Ketik perintah systemctl berikut
{% highlight bash %}
sudo systemctl enable rc-local.service
{% endhighlight %}

Sekarang dapat menggunakan /etc/rc.local untuk mengembalikan aturan iptables saat boot. Lihat cara mengaktifkan skrip shell rc.local di systemd saat mem-boot sistem Linux.

Kesimpulan

Halaman tutorial singkat ini menjelaskan beberapa cara di mana aturan iptables dapat disimpan atau direstore secara permanen di Linux.

Perintah Simpan Firewall Rules Debian/Ubuntu:

{% highlight bash %}
iptables-save > rules.v4
ip6tables-save > rules.v6
{% endhighlight %}

Debian/Ubuntu Perintah Restore Firewall Rules
{% highlight bash %}
iptables-restore < rules.v4
ip6tables-restore < rules.v6
{% endhighlight %}

Perintah simpan Rules Firewall RHEL/CentOS/Fedora:

{% highlight bash %}
iptables-save > /etc/sysconfig/iptables
ip6tables-save > /etc/sysconfig/ip6tables
{% endhighlight %}


Perintah Restore Firewall Rules RHEL/CentOS/Fedora:
{% highlight bash %}
iptables-restore < /etc/sysconfig/iptables
ip6tables-restore < /etc/sysconfig/ip6tables
{% endhighlight %}

Referensi : [LINK](https://gist.github.com/davydany/0ad377f6de3c70056d2bd0f1549e1017)