---
layout: post
title: Meningkatkan Performa Python dengan Cython
modified: 2023-05-10T17:00:28+07:00
categories:
description: "Meningkatkan Performa Python dengan Cython"
tags: [cython, python, c++]
image:
  background: triangular.png
comments: true
share: true
date: 2023-05-10T17:00:28+07:00
---

"Cython adalah modul dan bahasa yang digunakan oleh para pengembang Python untuk mempercepat kode mereka"c

Bagaimana Cython bekerja? Apa itu Cython? Haruskah Anda menulis semua kode Python Anda dengan Cython? Seberapa cepat Cython membuat kode Anda? Dan apakah selalu berhasil?

Dalam tutorial ini, kami akan memperkenalkan Anda pada Cython dan menjelaskan mengapa Anda harus menggunakannya saat menulis kode Python. Kami juga akan membahas pipa kompilasi Cython dan skenario penggunaan umum serta membimbing Anda dalam instalasi dan pengaturan.

Kami akan membahas hal berikut dengan contoh nyata:

- Apa itu Cython?
- Apa yang ditawarkan oleh Cython?
- Pipa kompilasi Cython
- Kapan menggunakan Cython
- Perbandingan performa antara Python dan Cython

Tujuan panduan ini adalah membantu Anda memahami Cython dengan lebih baik dan bagaimana ia mempercepat Python menggunakan program pencarian bilangan prima sederhana.

Apa itu Cython?

Cython dapat dianggap sebagai modul dan bahasa pemrograman yang (secara berurutan) memperluas Python dengan mengaktifkan penggunaan tipe data statis yang diambil dari C/C++. Pada dasarnya, semua kode Python valid dalam Cython, tetapi tidak sebaliknya.

Ingatlah, Anda dapat mengonversi Python menjadi Cython dan sebaliknya. Jika ini sulit dipahami, pikirkan hubungan antara C dan C++ atau JavaScript dan TypeScript. Anda dapat langsung menyalin kode Python yang ada ke file Cython dan kemudian mengompilasinya untuk meningkatkan performa.

Apa yang ditawarkan oleh Cython?

Dalam pengetahuan umum, Python lebih efisien daripada C karena Python adalah bahasa tingkat tinggi. Meskipun demikian, ada kekurangan dalam menggunakan Python dibandingkan dengan C/C++.

Python efisien tetapi lambat. C, di sisi lain, kurang efisien tetapi lebih cepat daripada Python. Oleh karena itu, Cython bertujuan untuk memberikan semua keuntungan C ke Python sambil mempertahankan efisiensi yang diharapkan oleh pengembang Python.

Untuk memahaminya lebih lanjut, Anda perlu memahami terlebih dahulu bagaimana kode Python dieksekusi. Dalam proses eksekusi (yaitu, di interpreter), kode sumber Python melalui kompilator, yang bertindak sebagai penerjemah untuk mengonversi kode sumber menjadi bytecode yang independen dari platform.

Setelah itu, mesin virtual Python mengeksekusi bytecode baris per baris. Karena ini terjadi secara langsung selama waktu eksekusi, eksekusi baris per baris membuat proses tersebut lambat dibandingkan dengan bahasa yang dikompilasi.

![gambar cython 1](/images/2023/cython-1.png)

Jika Anda membandingkannya dengan diagram blok bahasa yang dikompilasi, kode sumber diubah menjadi kode mesin yang dapat langsung dijalankan pada arsitektur. Ini sangat cepat dibandingkan dengan proses oleh interpreter.

Kekurangan dari pendekatan ini adalah bahwa kode mesin bergantung pada platform, yang berarti Anda tidak dapat menjalankan kode yang sama di platform yang berbeda.

Sekarang Anda dapat melihat apa yang kedua konsep tersebut tawarkan. C membawa tipe data statis ke Python dan Python membawa efisiensi ke C.

![gambar cython 2](/images/2023/cython-2.png)

Pipeline kompilasi Cython

Seperti apa pipeline Cython? Kompilasi dalam Cython adalah proses dua langkah.

Pada langkah pertama, kode Cython Anda diubah menjadi kode C atau C++ yang dioptimalkan dan tidak tergantung pada platform. Dari sana, kode sumber C atau C++ diubah menjadi file objek bersama melalui compiler C atau C++. Namun, file objek bersama ini tergantung pada platform. Pada sistem operasi Linux atau Mac OS, file ini memiliki ekstensi *.so, sedangkan pada Windows memiliki ekstensi *.pyd.

![gambar cython 3](/images/2023/cython-3.png)

Kapan Menggunakan Cython ?

Dalam situasi apa Anda mungkin perlu menggunakan Cython? Apakah itu bekerja di semua tempat setiap saat?

Nah, ya dan tidak. Menggunakan Cython di mana-mana tidak selalu menjamin peningkatan kecepatan. Namun, Anda dapat menggunakannya dalam fungsi yang melibatkan banyak operasi matematika dan iterasi loop. Hal ini karena mendefinisikan tipe sebelum menjalankan operasi membuatnya lebih mudah saat dilakukan eksekusi, terutama dalam loop di mana variabel dianalisis dan diulang beberapa kali.

Kasus penggunaan yang bagus lainnya adalah ketika Anda sudah memiliki perpustakaan C atau C++ yang membutuhkan antarmuka Python. Dalam hal ini, Anda dapat menggunakan Cython untuk membuat wrapper untuk perpustakaan tersebut.

Python vs. Cython: Membandingkan kinerja

Sekarang mari kita buat proyek contoh untuk melihat Cython dalam aksi.

Langkah pertama adalah membuka terminal, mengatur lingkungan yang aman untuk bekerja (opsional), dan menginstal Cython beserta dependensi yang diperlukan.

    $ sudo apt install build-essential

Ini akan membuat kompiler gcc tersedia jika komputer Anda belum memiliki kompiler tersebut.

    $ sudo apt install python3-venv

Ini menyediakan lingkungan aman bagi Anda untuk bekerja dengan aman. Langkah ini tidak diperlukan, tetapi selalu baik untuk membuat proyek Anda dalam lingkungan virtual terpisah agar dependensi tidak saling bertentangan.

    $ sudo pip3 install cython

Ini menginstal Cython ke mesin Anda.

Setelah instalasi selesai, kita dapat mulai.

Dalam demonstrasi ini, kita akan menulis dua fungsi sederhana dalam satu file yang sama, yang disebut main.pyx, untuk mencari beberapa bilangan prima. Kita akan menulis satu dalam Python dasar dan satu lagi dalam Cython. Dari sana, kita akan menjalankan keduanya dan mengukur perbedaan waktu eksekusi.

Perhatikan bahwa semua file untuk demonstrasi ini akan berada dalam satu direktori. Juga, daripada menggunakan ekstensi .py dalam file ini, Anda akan menggunakan .pyx karena Anda sudah menginstal Cython di mesin atau lingkungan Anda.

    # 1. The basic Python function

    """
    Dalam fungsi ini, yang akan Anda harapkan sebagai nilai pengembalian adalah daftar dari beberapa angka pertama tergantung pada apa yang Anda masukkan sebagai parameter masukan. Daftar angka prima yang ditemukan akan kosong pada awalnya.
    """
    def prime_finder_py ( amount ):
    primes = []
    found = 0
    number = 2

    while found < amount:
    for x in primes:
        if number % x == 0:
        break
        else:
        primes.append ( number )

    found += 1
    number += 1
    
    return primes

    """
    Hal yang Anda periksa hanya pada baris 12 adalah apakah angka baru yang sedang Anda periksa dapat dibagi habis oleh angka prima. Angka yang ditambahkan ke dalam array hanya akan ada di sana jika tidak ada satu pun angka di bawahnya yang dapat membaginya.

    Baris 19 memastikan bahwa perulangan berjalan dari satu angka ke angka berikutnya secara progresif, terlepas dari apakah itu ditambahkan ke dalam array angka prima.
    """

    # 2. The Cython Function

    """
    Pertama-tama, Anda harus mendefinisikan variabel-variabel ini karena Anda tidak ingin mendefinisikannya secara langsung saat sedang mencoba mengoptimalkan Python menggunakan sintaksis C.

    Selain itu, dalam pemrograman C, Anda selalu harus mendefinisikan array Anda dengan ukuran tetap seperti yang saya lakukan pada baris 10.

    Baris 13 adalah sebagai langkah pencegahan jika Anda memilih angka yang melebihi batas ini (yang dapat Anda ubah, by the way).
    """

    def prime_finder_cy ( int amount ):
    cdef int number, x, found
    cdef prime[50000]
    amount = min ( amount, 50000 )

    found = 0
    number = 2
    while found < amount:
        for x in primes[ :found]:
        if number % x == 0:
            break
        else:
            primes[found] = number
            found += 1

        number += 1
    
    return_list = [p for p in primes[ :found]]
    return return_list


    '''
    Untuk loop for pada baris 19, Anda perlu menyesuaikannya sedikit karena Anda sebenarnya tidak ingin menjalankan seluruh nilai dari array tetap Anda bahkan ketika Anda tidak memiliki begitu banyak angka dalam array tersebut. Oleh karena itu, loop hanya perlu berjalan hingga indeks 'found'. Dengan cara itu, loop hanya akan berjalan hingga indeks terakhir dari 'found'.

    Baris 28 memastikan bahwa Anda hanya memiliki elemen yang Anda butuhkan dan bukan seluruh panjang array.
    '''

Seperti yang dapat Anda lihat, logika bagaimana kami menemukan angka prima sama persis. Anda tidak mengubah apa pun. Sebenarnya, Anda memiliki lebih banyak kode dalam sintaksis Cython.

Jika Anda melihat implementasi Cython, Anda akan melihat bahwa Anda memiliki array dengan ukuran tetap dengan slot kosong yang berlebihan. Anda memiliki definisi tipe dan beberapa kode tambahan. Anda mungkin berpikir ini akan menyebabkan kinerja yang lebih lambat karena fakta sederhana bahwa ada lebih banyak kode. Namun, Anda akan melihat bahwa kode Cython jauh lebih cepat daripada kode Python.

Buat file lain dalam direktori yang sama dan beri nama apa saja dengan ekstensi .py. Untuk contoh ini, saya memberi nama file saya setup.py.

Di dalam file setup.py, impor dari setuptools dan cythonize dari Cython.Build, seperti ini:

    from setuptools import setup
    from Cython.Build import cythonize

Yang perlu Anda lakukan di file ini adalah menambahkan potongan kode berikut:

    from setuptools import setup
    from Cython.Build import cythonize

setup (
ext_modules = cythonize ( ‘main.pyx’ )
)

Setelah itu, Anda tidak hanya menjalankannya di IDE Anda; Anda harus menjalankannya dari terminal. Buka direktori tersebut di terminal dan jalankan perintah berikut:

    $ python setup.py build_ext --inplace

Perintah ini akan menghasilkan file main.c dan file .so jika Anda menggunakan Linux, atau file .pyd jika Anda menggunakan Windows.

Dari sini, Anda tidak lagi memerlukan file main.pyx. Anda hanya memerlukan file *.so dan file baru lainnya untuk menguji fungsi.

Anda dapat memberi nama file .py baru apa pun yang Anda inginkan; untuk tujuan contoh ini, kita akan namai test.py

Di file test.py, Anda perlu mengimpor main, yang merupakan file biner, dan time, yang akan Anda gunakan untuk membandingkan waktu eksekusi.

Jangan khawatir — Anda hampir selesai.

Setelah mengimpor main dan time, Anda dapat mulai memanggil fungsi dengan melihat impor main, seperti ini:

    import main
    import time

    # example call
    print( main.prime_finder_py(x) )
    print( main.prime_finder_cy(x) )

    '''
    X dalam tanda kurung parameter adalah jumlah bilangan prima yang ingin ditampilkan oleh program.
    '''

Sekarang saatnya untuk bagian yang menyenangkan.

Untuk menentukan waktu yang dibutuhkan oleh fungsi-fungsi, Anda perlu menambahkan variabel waktu dan menggunakan modul time yang telah Anda impor.

    import main
    import time

    start_py = time.time() '''records time before function runs'''
    print( main.prime_finder_py(x) )
    end_py = time.time() '''records time after function has run'''

    time_py = end_py – start_py

    start_cy = time.time() '''records time before function runs'''
    print( main.prime_finder_cy(x) )
    end_cy = time.time() '''records time after function has run'''

    time_cy = end_cy – start_cy

    if time_cy < time_py:
    print ( ‘ The Cython implementation is faster ’)
    else:
    print ( ‘The Python implementation is faster ’ )

Sebagian besar kode ini cukup sederhana. Pada dasarnya, jika Anda menjalankan file test.py ini di IDE Anda, bagian pertama akan mencatat waktu yang dibutuhkan oleh fungsi Python untuk berjalan. Bagian kedua melakukan hal yang sama untuk fungsi Cython. Pernyataan if membandingkan dua nilai waktu eksekusi yang dihitung dan mengevaluasi fungsi mana yang lebih cepat dari yang lain.

Perhatikan bahwa Anda harus menggunakan angka besar dalam parameter Anda, jika tidak Anda tidak akan melihat perbedaannya. Cobalah menggunakan 20.000 sebagai parameter dan lihat apa yang terjadi. Anda bahkan dapat mencoba menambahkan pernyataan cetak untuk melihat nilai yang tepat dari variabel waktu untuk setiap fungsi. Bersenang-senanglah dengan itu.

Bagaimanapun, ini hanya karena Cython telah menambahkan tipe statis. Anda tidak mengubah hal-hal kompleksitas algoritma atau menyimpan sesuatu secara tidak sengaja di cache. Pada dasarnya, Anda mengorbankan sebagian fleksibilitas Python untuk peningkatan besar dalam waktu eksekusi.

## Kesimpulan

Sekarang setelah kita melalui latihan ini, apakah memperkenalkan Cython ke kode Python Anda membantu? Ya, tetapi tidak selalu.

Ketika operasi terikat pada CPU, artinya seluruh waktu runtime dihabiskan untuk memanipulasi beberapa nilai di dalam register CPU dan sedikit atau tidak ada pergerakan data yang diperlukan, Cython kemungkinan besar akan meningkatkan kinerja dengan memperkenalkan variabel yang diberi tipe statis dan pustaka objek bersama. Namun, ini tidak dapat membantu ketika operasi yang terikat pada IO (misalnya, membaca file besar dari disk) atau terikat pada jaringan (yaitu, mengunduh file dari server FTP) menjadi bottleneck.

Jadi, ketika memperkenalkan Cython ke kode Python Anda, Anda perlu melakukan profil pada kode Anda dan menentukan jenis bottleneck yang Anda miliki.