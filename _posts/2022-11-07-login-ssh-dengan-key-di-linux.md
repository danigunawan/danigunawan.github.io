---
layout: post
title: Login SSH Dengan Key Di Linux
description: "Login SSH Dengan Key Di Linux"
tags: [linux administration, ssh]
image:
  background: triangular.png
---

<div style="text-align: justify">
dalam melakukan akses login ke remote server dengan SSH biasanya kita memakai Password. Lebih amannya, Password dapat diganti dengan menggunakan Public Key. Public Key yang dibuat di komputer dicopy ke folder ~/.ssh/authorized_keys. Jika key yang ada di komputer tidak sama persis dengan key yang ada di server meskipun itu penambahan spasi, maka tidak akan bisa login dikarenakan terjadi kegagalan verifikasi key yang digunakan untuk akses login.
</div>

{% highlight sql %} 

# Generate key di Linux

ssh-keygen -t rsa -b 4096 -C "ganteng@gmail.com"

# Masukkan nama file untuk menyimpan key. Setelahnya Enter/kosongkan saja. Passphrase untuk memberi proteksi password pada key sebelum digunakan.

# Enter file in which to save the key (/home/ganteng/.ssh/id_rsa): /home/ganteng/.ssh/id_rsa

# File key yang sudah digenerate ada 2, public key .pub dan private key. Buka file public key id_rsa.pub, copy isinya.

# Di server buat folder dan file authorized_keys. Paste public key yang sudah dicopy ke nano editor.

mkdir ~/.ssh
cd ~/.ssh
nano authorized_keys

# Sekarang login ke server seperti biasa, apakah masih meminta password atau langsung login.

ssh ganteng@IPSERVER

# Atau bisa menyebut secara spesifik file key yang digunakan.

ssh -i ~/.ssh/id_rsa.pub ganteng@IPSERVER

# Untuk menonaktifkan login dengan password, set PasswordAuthentication no pada konfigurasi SSH server.

nano /etc/ssh/sshd_config

# Cari baris di bawah ini

# Change to no to disable tunnelled clear text passwords
PasswordAuthentication no

# Restart SSH service

/etc/init.d/ssh restart
{% endhighlight %}