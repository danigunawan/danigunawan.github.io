---
layout: post
title: Load Testing Dengan Apache Benchmark
modified: 2023-05-24T17:00:28+07:00
categories:
description: "Load Testing Dengan Apache Benchmark"
tags: [loadtesting, QPS, apache]
image:
  background: triangular.png
comments: true
share: true
date: 2023-05-24T17:00:28+07:00
---

ApacheBench (ab) adalah sebuah perangkat lunak yang digunakan untuk melakukan pengujian beban (load testing) pada server web. Pengujian beban dilakukan dengan mengirimkan serangkaian permintaan HTTP ke server untuk mengukur kinerja dan kapasitasnya. QPS (Queries Per Second) adalah ukuran yang digunakan untuk menentukan jumlah permintaan yang dapat ditangani oleh server dalam satu detik.

Berikut ini adalah langkah-langkah umum untuk menginstal Apache HTTP Server dan ApacheBench:

Buka terminal atau command prompt.

Jika Anda menggunakan distribusi Linux seperti Ubuntu, Debian, atau CentOS, gunakan perintah berikut untuk menginstal Apache HTTP Server dan ApacheBench:

Ubuntu atau Debian:

    sudo apt update
    sudo apt install apache2 apache2-utils

    sudo yum update
    sudo yum install httpd httpd-tools

Jika Anda menggunakan distribusi lain atau ingin menginstal ApacheBench secara terpisah, Anda dapat mengunduh dan mengompilasi Apache HTTP Server dari sumber resmi. Kunjungi situs web Apache HTTP Server (https://httpd.apache.org/) dan unduh versi terbaru.

Ekstrak arsip yang diunduh.

Buka terminal atau command prompt dan pindah ke direktori hasil ekstraksi.

Jalankan langkah-langkah berikut untuk mengompilasi dan menginstal Apache HTTP Server:

    ./configure
    make
    sudo make install

Proses ini akan mengompilasi Apache HTTP Server dan menginstalnya di sistem Anda.

Setelah selesai menginstal Apache HTTP Server, ApacheBench (ab) juga akan terinstal sebagai bagian dari paket.

Untuk memastikan ApacheBench terinstal dengan benar, jalankan perintah berikut di terminal atau command prompt:

    ab -V

Jika ApacheBench terinstal dengan sukses, Anda akan melihat output yang mencantumkan versi ApacheBench yang terpasang.

Sekarang, Anda telah berhasil menginstal Apache HTTP Server dan ApacheBench. Anda dapat menggunakan perintah ab untuk melakukan pengujian beban (load testing) pada server web yang diinginkan.

Untuk melakukan pengujian beban menggunakan ApacheBench, Anda dapat mengikuti langkah-langkah berikut:

Instalasi ApacheBench: ApacheBench sudah tersedia secara default di banyak distribusi Linux. Jika Anda menggunakan Linux, kemungkinan besar sudah terpasang. Jika tidak, Anda dapat menginstalnya melalui paket manajer sistem operasi yang Anda gunakan. Jika Anda menggunakan Windows, Anda dapat mengunduh ApacheBench dari situs resmi Apache HTTP Server.

Buka terminal atau command prompt.

Gunakan perintah berikut untuk menjalankan pengujian beban dengan ApacheBench:

    ab -n jumlah_permintaan -c jumlah_konkurensi URL

jumlah_permintaan adalah jumlah total permintaan yang akan dikirimkan ke server.
jumlah_konkurensi adalah jumlah permintaan yang akan dikirimkan secara bersamaan (konkurensi).
URL adalah alamat URL server yang akan diuji.

Contoh:

    ab -n 1000 -c 10 http://localhost/

Perintah di atas akan mengirim 1000 permintaan dengan tingkat konkurensi 10 ke http://localhost/.

Setelah pengujian selesai, ApacheBench akan menampilkan hasilnya, termasuk rata-rata QPS (Transactions per second) yang diukur selama pengujian.

Perlu diingat bahwa hasil pengujian beban dapat dipengaruhi oleh banyak faktor, seperti spesifikasi server, jaringan, dan jenis permintaan yang dikirimkan. Oleh karena itu, hasil pengujian dapat berbeda-beda pada setiap situasi.

Dalam konteks pengujian beban (load testing), konkurensi (concurrency) merujuk pada jumlah permintaan yang dikirimkan secara bersamaan ke server dalam satu waktu. Ini menggambarkan seberapa banyak pengguna atau klien yang berinteraksi dengan server secara bersamaan.

Misalkan Anda mengatur tingkat konkurensi 10 dalam pengujian beban. Ini berarti pada setiap saat, ada 10 permintaan yang dikirimkan ke server secara bersamaan. Saat permintaan pertama sedang diproses oleh server, permintaan kedua, ketiga, dan seterusnya sedang dalam antrian menunggu. Begitu permintaan pertama selesai diproses, server akan memulai pemrosesan permintaan kedua, dan seterusnya. Tingkat konkurensi ini mencerminkan situasi di mana banyak pengguna atau klien mengakses server secara bersamaan.

Tingkat konkurensi yang tinggi dalam pengujian beban dapat membantu mengidentifikasi potensi masalah kinerja pada server. Hal ini karena memperoleh gambaran tentang seberapa baik server mengatasi beban yang tinggi dari pengguna yang berinteraksi secara bersamaan. Dalam pengujian beban, Anda dapat meningkatkan atau menurunkan tingkat konkurensi untuk mengamati bagaimana kinerja server berubah dengan adanya variasi jumlah pengguna yang aktif secara bersamaan.

Jadi, tingkat konkurensi dalam pengujian beban memainkan peran penting dalam mengevaluasi kemampuan server dalam menangani jumlah permintaan yang datang secara bersamaan dari pengguna yang berinteraksi dengan sistem.

Selain ApacheBench, ada juga banyak alat pengujian beban lainnya seperti JMeter, Gatling, dan Siege yang dapat digunakan untuk melakukan pengujian beban dengan cara yang serupa. Setiap alat memiliki fitur dan kemampuan yang berbeda, jadi penting untuk memilih alat yang sesuai dengan kebutuhan Anda.

Refferensi : 
https://httpd.apache.org/docs/2.4/programs/ab.html