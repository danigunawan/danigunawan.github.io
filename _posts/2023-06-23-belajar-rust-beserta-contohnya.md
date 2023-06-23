---
layout: post
title: Belajar Rust Beserta Contohnya
modified: 2023-06-23T17:00:28+07:00
categories:
description: "Belajar Rust Beserta Contohnya"
tags: [rust, rust by example]
image:
  background: triangular.png
comments: true
share: true
date: 2023-06-23T17:00:28+07:00
---

# Sekilas Tentang Rust
Rust adalah sebuah bahasa pemrograman sistem yang dikembangkan oleh Mozilla Research. Bahasa ini didesain untuk membangun aplikasi yang aman, konkuren, dan efisien dalam hal penggunaan sumber daya. Rust memiliki sintaks yang mirip dengan bahasa pemrograman C++, namun dengan fitur-fitur yang mengatasi masalah umum yang terkait dengan kesalahan memori dan kesalahan konkuransi.

Salah satu fitur utama Rust adalah sistem kepemilikan (ownership system) yang unik. Sistem ini memungkinkan Rust untuk memastikan keselamatan memori dan mencegah kesalahan umum seperti data race dan null pointer dereference. Dengan sistem kepemilikan ini, Rust memastikan bahwa setiap nilai hanya memiliki satu pemilik yang valid pada satu waktu tertentu, dan aturan yang ketat diterapkan untuk memastikan pengelolaan sumber daya yang benar.

Selain itu, Rust juga memiliki sistem pinjaman (borrowing system) yang memungkinkan pengguna untuk meminjam referensi ke nilai tanpa mentransfer kepemilikan penuh. Hal ini memungkinkan pemrogram untuk menghindari overhead yang terkait dengan salinan data besar, sambil tetap memastikan keamanan dan integritas data.

Rust juga menawarkan fitur pemrograman fungsional dan pemrograman konkuren yang kuat, serta dukungan yang baik untuk pengembangan aplikasi berskala besar. Banyak proyek open-source dan industri yang menggunakan Rust untuk mengembangkan sistem perangkat lunak yang kritis dan performa tinggi seperti mesin game, sistem operasi, perangkat lunak jaringan, dan banyak lagi.

Dalam beberapa tahun terakhir, Rust telah menjadi semakin populer di kalangan pengembang karena kombinasi keamanan, keandalan, dan performanya yang tinggi.

![rust benchmark](/images/2023/rust_benchmark.png)


# Belajar Rust Beserta Contohnya

Rust by Example (RBE) adalah kumpulan contoh program yang dapat dijalankan yang menggambarkan berbagai konsep Rust dan pustaka standar. RBE memberikan contoh konkret tentang cara menggunakan fitur-fitur Rust dan pustaka standarnya dalam bentuk program yang dapat dijalankan.

Prerequisite
- Install Rust : https://www.rust-lang.org/tools/install
- Dokumentasi : https://doc.rust-lang.org/std/

Berikut adalah daftar topik yang dicakup dalam Rust by Example:

    Hello World - Memulai dengan program Hello World tradisional.
    Primitives - Memahami tentang tipe data primitif seperti bilangan bulat berbantuan (signed integers), bilangan bulat tak berbantuan (unsigned integers), dan primitif lainnya.
    Custom Types - Memahami penggunaan struktur (struct) dan enumerasi (enum) untuk membuat tipe data kustom.
    Variable Bindings - Memahami pengikatan variabel (variable bindings) yang dapat diubah (mutable bindings), cakupan (scope), dan shadowing.
    Types - Memahami bagaimana mengubah dan mendefinisikan tipe data.
    Conversion - Mengubah tipe data dari satu jenis ke jenis lainnya.
    Expressions - Memahami ekspresi dalam bahasa Rust.
    Flow of Control - Memahami kontrol alur program seperti if/else, for, dan lainnya.
    Functions - Memahami metode (methods), penutupan (closures), dan fungsi tingkat tinggi (higher order functions).
    Modules - Mengorganisir kode menggunakan modul.
    Crates - Memahami tentang pembuatan pustaka (library) dalam Rust.
    Cargo - Memahami beberapa fitur dasar dari alat manajemen paket resmi Rust, yaitu Cargo.
    Attributes - Menggunakan atribut untuk memberikan metadata pada modul, kumpulan kode, atau item.
    Generics - Memahami cara menulis fungsi atau tipe data yang dapat digunakan untuk beberapa jenis argumen.
    Scoping rules - Memahami peran cakupan (scope) dalam kepemilikan, peminjaman, dan rentang hidup (lifetimes).
    Traits - Memahami konsep trait, yaitu kumpulan metode yang didefinisikan untuk tipe yang tidak diketahui: Self.
    Macros - Menggunakan makro dalam Rust.
    Error handling - Memahami cara Rust mengatasi kegagalan.
    Std library types - Memahami beberapa tipe data kustom yang disediakan oleh pustaka standar Rust.
    Std misc - Memahami tipe data kustom lainnya untuk penanganan berkas (file handling), pengelolaan utas (threading), dan sebagainya.
    Testing - Memahami berbagai jenis pengujian (testing) dalam Rust.
    Unsafe Operations - Memahami operasi yang tidak aman (unsafe operations) dalam Rust.
    Compatibility - Memahami kompatibilitas Rust dengan kode C dan C++.
    Meta - Dokumentasi, pengujian kinerja (benchmarking), dan topik lainnya terkait Rust.

Rust by Example merupakan sumber yang bagus untuk belajar bahasa Rust dengan contoh konkret yang dapat dieksekusi.

# Frameworks

Di dunia pemrograman Rust, terdapat beberapa framework yang populer dan digunakan untuk membangun aplikasi web dan layanan jaringan. Berikut ini adalah beberapa framework Rust yang terkenal:

1. Rocket: Rocket adalah framework web yang sangat populer dan mudah digunakan. Ia menekankan pada kesederhanaan, kinerja tinggi, dan keamanan. Rocket menggunakan makro Rust untuk menyediakan sintaks yang intuitif dan menyenangkan. Ia juga memiliki sistem tipe yang kuat untuk mencegah kesalahan pada waktu kompilasi.

1. Actix: Actix adalah framework web dan layanan jaringan yang berkinerja tinggi dan tangguh. Ia didesain untuk menangani lalu lintas yang tinggi dan skalabilitas yang baik. Actix menggunakan pemodelan actor untuk mengelola pemrosesan konkuren dan memastikan keselamatan dalam pemrograman konkuren.

1. Tide: Tide adalah framework web yang ringan dan intuitif. Ia menggunakan abstraksi modern seperti async/await dan Future untuk menghadirkan pemrograman yang non-blokir dan efisien. Tide juga memanfaatkan sistem tipe Rust untuk mencegah kesalahan pada waktu kompilasi.

1. Warp: Warp adalah framework web ringan dan cepat yang menggunakan combinators untuk menyusun rute dan middleware. Ia menyediakan alat yang kuat untuk menangani permintaan HTTP dengan cara yang mudah dipahami dan terstruktur. Warp juga menekankan kinerja yang tinggi dengan menggunakan asinkronisitas.

1. Nickel: Nickel adalah framework web yang bersifat modular dan fleksibel. Ia mengikuti paradigma middleware dan menyediakan alat yang kuat untuk mengembangkan aplikasi web dengan mudah. Nickel juga mendukung penggunaan makro Rust untuk membuat sintaks yang deklaratif dan mudah dibaca.

1. Rocket.rs: Rocket.rs adalah sebuah framework web yang memungkinkan pengembangan aplikasi web yang aman, cepat, dan dapat diskalakan. Ia menggabungkan fitur-fitur seperti routing, input parsing, dan validasi data dengan sistem tipe yang kuat untuk menghindari banyak jenis kesalahan umum dalam pengembangan web.

1. Yew: Yew adalah framework front-end web yang menggunakan pemrograman fungsional reaktif untuk membangun antarmuka pengguna yang interaktif. Ia mengintegrasikan Rust dengan DOM (Document Object Model) melalui WebAssembly dan menyediakan alat untuk mengelola keadaan aplikasi dengan mudah.

1. salvo.rs: Salvo.rs menawarkan fitur-fitur seperti routing HTTP, middleware, penanganan request dan response, serta dukungan untuk asynchronous programming. Framework ini didesain dengan fokus pada performa yang tinggi dan keamanan. Salvo.rs memiliki sintaks yang bersih dan mudah dipahami, sehingga memudahkan pengembang untuk membuat aplikasi web yang efisien dan andal menggunakan bahasa Rust. Framework ini juga kompatibel dengan ecosystem Rust yang luas, sehingga memungkinkan pengguna untuk memanfaatkan berbagai pustaka dan alat bantu lainnya yang tersedia dalam ekosistem Rust.

Itu hanya beberapa contoh dari berbagai framework yang tersedia dalam ekosistem Rust. Setiap framework memiliki keunikan dan tujuan yang berbeda-beda, sehingga pemilihan framework tergantung pada kebutuhan dan preferensi pengembang.

Reff : 
- https://doc.rust-lang.org/rust-by-example/
- https://doc.rust-lang.org/std/
- https://www.rust-lang.org/tools/install
