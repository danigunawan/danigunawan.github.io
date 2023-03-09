---
layout: post
title: SSL Gratis Dengan Letsencrypt
modified: 2023-02-22T17:00:28+07:00
categories:
description: "SSL Gratis Dengan Letsencrypt"
tags: [ssl, free ssl]
image:
  background: triangular.png
comments: true
share: true
date: 2023-02-22T17:00:28+07:00
---

{% highlight bash %} 
Persiapan :
1. DNS A Record sudah terpointing beserta CNAME (www dan non-www)
2. Certbot (nginx atau apache)
3. Install webserver nginx atau apache 
4. Definisikan konfigurasi blok NS di nginx/apache (www dan non www)

# Instal Certbot Apache (Deb/Ubuntu Install)
sudo apt install certbot python3-certbot-apache

# Jalankan Certbot
sudo certbot run

# Membuat Penjadwalan certbot auto-renew
sudo crontab -e

Add:MAILTO="" # paling atas skrip cron ini akan menonaktifkan banyak email yang mengganggu.

Kemudian tambahkan ini ke bagian bawah skrip untuk menjalankan pembaruan setiap 7 hari:

0 5 */7 * * certbot renew --renew-hook "service restart apache2"

# Perbarui/install secara manual dan minta certbot membuat file apache.conf khusus

certbot --cert-name yourcertificatename -d site1.com -d site2.com -d site3.com

# Perbarui banyak secara manual hanya dengan sertifikat (tidak ada perubahan file konfigurasi). Ini berguna jika Anda perlu menambah atau menghapus domain.

certbot certonly --cert-name yourcertificatename -d site1.com -d site2.com -d site3.com

# Jalankan skrip cron untuk memperbarui sertifikat certbot secara otomatis, setiap 2 bulan

Pertama, ikuti petunjuk untuk menginstal sertifikat terlebih dahulu. Kemudian:

Buka crontab sebagai pengguna admin sudo crontab -e

Crontab akan meminta Anda untuk memilih editor Anda. Nano biasanya baik-baik saja.

Crontab menggunakan pola ini: {(minute) (hour) (day-of-month) (month) (day-of-week) (command)} semuanya dipisahkan oleh satu spasi.

Tambahkan baris ini ke akhir crontab Anda:
* 1 10 */2 * certbot certonly --force-renewal --webroot -w /path/to/web/root -d example.com

Ini memberi tahu crontab untuk mengeksekusi perintah certbot setiap menit setelah jam 1 pagi, pada tanggal 10 setiap bulan, setiap 2 bulan, setiap hari dalam seminggu.

Sub-perintah certonly memberi tahu Certbot untuk sekadar memperbarui sertifikat dan tidak mengubah file apache.conf.

Menurut dokumentasi Certbot "Jika Anda tidak menentukan perilaku yang diminta, Certbot mungkin menanyakan apa yang Anda maksudkan." Jadi untuk menghindari mengajukan pertanyaan dalam proses otomatis kami, kami menggunakan opsi --force-renewal.

Opsi --webroot memberi tahu Certbot untuk menggunakan tipe autentikasi http-01.

Bendera -w menetapkan jalur ke webroot.

Dan terakhir flag -d memberi tahu Certbot domain mana yang akan diperbarui.

# Instal Certbot Nginx (Deb/Ubuntu Install)
sudo apt install certbot python3-certbot-nginx

- Buat SSL by Certbot
sudo certbot --nginx -d your_domain -d www.your_domain
- Perbaharui Sertifikat SSL
sudo certbot certonly -d your_domain -d www.your_domain
- Paksa Perbaharui Sertifikat SSL
sudo certbot certonly --force-renew -d your_domain -d www.your_domain

Referensi : 
- https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04

- https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04

{% endhighlight %}

