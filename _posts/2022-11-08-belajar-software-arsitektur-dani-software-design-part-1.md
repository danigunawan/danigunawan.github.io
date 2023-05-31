---
layout: post
title: Belajar Software Arsitektur dan Software Design - Part 1
modified: 2022-11-8T20:00:28+07:00
categories:
description: "Belajar Software Arsitektur dan Software Design - Part 1"
tags: [software architecture, software design]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-8T17:00:28+07:00
---

<div style="text-align: justify">
Arsitektur itu di ibaratkan sebuah bangunan lalu desain adalah pola rancangan arsitektur tersebut yang lebih detail yang nantinya di implementasi sesuai kebutuhan, kayak kita mahu bangun sebuah bangunan aja pilih arsitektur nya seperti apa mahu arsitektur rumah, gedung, atau bikin rumah kos-kosan, lalu desainnya mahu pakai cat apa, batakonya apa, semennya apa seperti halnya komponen-komponen detail sebuah bangunan yang mendukung <strong>arsitektur</strong>, tugas desainer tentunya lebih detail sehingga bangunan yang dibangun menjadi indah, kokoh, aman, bertahan lama dan sesuai kebutuhan.
</div>

Oke Lanjut..

<div style="text-align: justify">
Dari pengertian diatas jika berbicara arsitektur perangkat lunak, dan desain perangkat lunak, tentunya akan meletakkan semua itu pada prinsip-prinsip, metodologi, dan pola pengembangan aplikasi / perangkat lunak modern yang best practices, sesuai spesifikasi dan standar tujuannya agar rancangan sebuah aplikasi dapat sesuai kebutuhan, cepat dan tidak lambat, low cost, aman dari serangan hekel, flexible tentunya bisa di kembangin secara terus-menerus "reusable", intinya bisa effektif dan effisien (ujungnya pasti kesini karena notabene aplikasi adalah platform digunakan untuk sebuah layanan dan layanan harus memudahkan, menguntungkan untuk si pemakai istilah nya pengguna (harus dapat outcome nya gitu hehe). Apalagi di era saat ini teknologi sudah banyak bertransformasi dan meninggalkan hal-hal yang tradisional, meningkatnya demand sebuah layanan teknologi inginnya cepat dalam proses pengembangan hingga live produksi. teknologi cloud computing sudah banyak membantu dalam komponen pengembangan software architecture dan desain hal-hal teknologi yang tradisional atau depreceated sudah mulai di improve dan dikemas dalam produk-produk teknologi cloud menjadi modern stack, jadi kita sudah dipermudah. Dalam menulis untuk memperkaya informasi yang saya dapat beserta pengalaman, saya menggabungkan metode 5W1H jadi biar balance antara materi dan realita ciaaaa hihiy... (sabar ya yang masih joms), oh ya metode ini yang saya masih ingat dari sekolah SD sampai sekarang :D
</div>

## What ?

Apa Itu Software Arsitektur?
Software architecture adalah konsep dan prinsip-prinsip yang digunakan dalam merancang struktur organisasi perangkat lunak. Ini melibatkan pengambilan keputusan tentang elemen-elemen penting dalam perangkat lunak, termasuk komponen, pola desain, antarmuka, dan hubungan antara mereka.

Arsitektur perangkat lunak menggambarkan struktur dan interaksi antara komponen-komponen perangkat lunak, serta aturan dan keputusan desain yang membentuk sistem secara keseluruhan. Tujuan dari arsitektur perangkat lunak adalah untuk menciptakan sistem yang dapat dipahami, dapat dipelihara, dan dapat diperluas dengan baik.

Arsitektur perangkat lunak memainkan peran penting dalam pengembangan perangkat lunak yang sukses. Hal ini membantu dalam mengatur kompleksitas sistem, mengoptimalkan kinerja, meningkatkan keandalan, meningkatkan skalabilitas, dan memfasilitasi perubahan dan evolusi sistem.

Dalam praktiknya, arsitektur perangkat lunak biasanya diwujudkan dalam bentuk diagram seperti diagram blok, diagram komponen, diagram aliran data, atau diagram lainnya yang memvisualisasikan elemen-elemen arsitektur dan hubungan antara mereka.

Berikut adalah beberapa istilah yang umum digunakan dalam arsitektur perangkat lunak:

    Arsitektur Perangkat Lunak (Software Architecture): Merujuk pada desain tingkat tinggi yang menentukan struktur organisasi dan komponen perangkat lunak. Ini melibatkan pengambilan keputusan tentang elemen-elemen penting seperti pola desain, komponen, antarmuka, dan hubungan antara mereka.

    Komponen (Component): Unit modular dalam perangkat lunak yang memiliki tanggung jawab tertentu dan dapat berinteraksi dengan komponen lain. Komponen dapat digunakan ulang dan memungkinkan pemisahan tanggung jawab dalam sistem.

    Pola Desain (Design Patterns): Solusi umum yang telah terbukti untuk masalah desain perangkat lunak yang umum. Pola desain menyediakan pendekatan yang diuji waktu untuk memecahkan masalah tertentu dan membantu dalam pengembangan perangkat lunak yang lebih terstruktur dan dapat dipelihara.

    Arsitektur Berorientasi Layanan (Service-Oriented Architecture, SOA): Pendekatan arsitektur yang berfokus pada pemisahan fungsionalitas perangkat lunak menjadi layanan yang independen. Layanan ini berkomunikasi melalui antarmuka terdefinisi dan dapat digunakan ulang dan diintegrasikan dengan fleksibilitas.

    Arsitektur Berorientasi Mikro (Microservices Architecture): Pendekatan arsitektur yang mengorganisasi aplikasi sebagai sekumpulan layanan kecil, terisolasi, dan independen. Setiap layanan memiliki tanggung jawab spesifik dan berkomunikasi melalui protokol ringan seperti HTTP atau pesan antara proses.

    Arsitektur Berbasis Model (Model-Driven Architecture, MDA): Pendekatan arsitektur yang menggunakan model perangkat lunak sebagai artefak utama dalam siklus hidup pengembangan perangkat lunak. Model ini digunakan untuk menghasilkan kode sumber dan komponen perangkat lunak.

    Arsitektur Berbasis Layanan (Service-Based Architecture): Pendekatan arsitektur yang melibatkan pembagian fungsionalitas aplikasi menjadi layanan yang dapat diakses melalui antarmuka yang ditentukan. Layanan ini bisa berjalan di lingkungan yang terdistribusi dan berkomunikasi melalui protokol seperti SOAP atau REST.

    Arsitektur Berorientasi Kejadian (Event-Driven Architecture, EDA): Pendekatan arsitektur yang berfokus pada aliran peristiwa dalam sistem. Komponen-komponen dalam arsitektur ini berkomunikasi melalui peristiwa dan respon terhadap perubahan status dan kejadian yang terjadi.

    Arsitektur Berorientasi Domain (Domain-Driven Architecture, DDD): Pendekatan yang menempatkan fokus pada pemodelan dan desain perangkat lunak berdasarkan pemahaman yang kuat tentang domain bisnis atau masalah yang sedang diselesaikan.

    Arsitektur Berbasis Layanan Web (Web Service-Based Architecture): Pendekatan yang menggunakan layanan web sebagai komponen utama dalam arsitektur. Layanan ini dapat diakses melalui protokol seperti SOAP atau REST dan memungkinkan aplikasi untuk berkomunikasi melalui jaringan.

Ini hanyalah beberapa istilah yang umum digunakan dalam arsitektur perangkat lunak, dan masih banyak lagi istilah yang terkait dengan konsep arsitektur yang lebih spesifik dan canggih.

Tradisional Vs Serverless ?

Tradisional dan serverless adalah dua pendekatan yang berbeda dalam pengembangan dan pengelolaan aplikasi. Berikut adalah perbandingan antara keduanya:

    Tradisional:
        Infrastruktur: Dalam pendekatan tradisional, Anda perlu mengelola dan menyediakan infrastruktur sendiri, seperti server fisik atau virtual, jaringan, basis data, dan sebagainya.
        Skala: Anda harus memperkirakan dan mengatur kapasitas infrastruktur sesuai dengan permintaan yang diharapkan. Jika aplikasi menghadapi lonjakan lalu lintas, Anda mungkin harus melakukan penyesuaian manual untuk menangani beban tersebut.
        Manajemen: Anda bertanggung jawab untuk mengelola semua aspek aplikasi, termasuk skalabilitas, toleransi kesalahan, pemantauan, dan keamanan.
        Biaya: Anda harus membayar untuk infrastruktur yang tetap, terlepas dari seberapa banyak aplikasi digunakan. Ini dapat menjadi mahal jika aplikasi mengalami fluktuasi lalu lintas yang tinggi atau jika permintaan tidak terduga.

    Serverless:
        Infrastruktur: Dalam pendekatan serverless, penyedia cloud mengelola infrastruktur untuk Anda. Anda tidak perlu memikirkan tentang server fisik atau virtual, jaringan, atau basis data. Pemrosesan aplikasi terjadi pada level fungsi.
        Skala: Serverless secara otomatis mengatur skala aplikasi sesuai dengan permintaan. Fungsi hanya dijalankan saat ada permintaan, dan penyedia cloud secara otomatis menangani penugasan sumber daya yang diperlukan.
        Manajemen: Anda masih bertanggung jawab untuk mengelola logika aplikasi, tetapi tugas seperti skalabilitas, toleransi kesalahan, pemantauan, dan keamanan diambil alih oleh penyedia cloud.
        Biaya: Anda hanya membayar untuk penggunaan yang sebenarnya. Anda tidak perlu membayar untuk infrastruktur yang tidak digunakan. Biaya serverless biasanya berdasarkan jumlah fungsi yang dijalankan dan waktu eksekusi fungsi.

Keuntungan serverless termasuk pemeliharaan infrastruktur yang lebih rendah, skalabilitas otomatis, dan model biaya yang lebih sesuai dengan penggunaan yang sebenarnya. Namun, pendekatan tradisional memberikan fleksibilitas yang lebih besar dalam hal kontrol dan konfigurasi infrastruktur.

Pilihan antara pendekatan tradisional dan serverless tergantung pada kebutuhan aplikasi Anda, tingkat kontrol yang Anda inginkan, dan sumber daya yang tersedia. Penting untuk mempertimbangkan keuntungan dan tantangan dari masing-masing pendekatan sebelum memutuskan mana yang paling sesuai dengan kebutuhan Anda.

## Who ?

Software Arsitektur Engineer ?

<div style="text-align: justify">
Software architect engineer adalah orang yang ahli dalam menciptakan desain high-level, mengembangkan suatu software dan merekomendasikan software tersebut kepada customer atau perusahaan tempat seorang software architect bekerja.
</div>

Soon

## Why ?

Soon

## When ?

Kapan harus dilibatkan software arsitek dan software design?

Soon

## Where ?

Dimana software arsitek dan design bekerja?

Soon

## How ?

Soon