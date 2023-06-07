---
layout: post
title: Pencarian Dengan Github API
modified: 2023-06-06T17:00:28+07:00
categories:
description: "Pencarian Dengan Github API"
tags: [github api, github]
image:
  background: triangular.png
comments: true
share: true
date: 2023-06-06T17:00:28+07:00
---

Pencarian di GitHub Menggunakan GitHub API

GitHub adalah layanan hosting berbasis web untuk kontrol versi menggunakan Git. GitHub banyak digunakan untuk menyimpan dan berbagi kode sumber komputer. Layanan ini menyediakan semua fungsi kontrol versi terdistribusi dan manajemen kode sumber dari Git, serta menambahkan fitur-fitur tambahan.

GitHub menyimpan lebih dari 3 juta repositori dengan lebih dari 1,7 juta pengembang yang menggunakannya setiap hari. Dengan begitu banyaknya data, pada awalnya mungkin terasa sulit untuk menemukan informasi yang diperlukan atau melakukan tugas-tugas berulang, dan di sinilah GitHub API menjadi berguna.

Dalam tutorial ini, Anda akan belajar bagaimana menggunakan GitHub API untuk mencari repositori dan file yang mencocokkan kata kunci tertentu, serta mengambil URL-nya menggunakan Python. Anda juga akan belajar cara mengunduh file atau folder tertentu dari sebuah repositori di GitHub.


1. Persiapan Proyek
    - Token Akses Personal
    - Persiapan Klien
2. Uji GitHub API
3. Pencarian Repositori di GitHub
    - Menangkap Kata Kunci
    - Pencarian Repositori
4. Pencarian File di GitHub
    - Menangkap Kata Kunci
    - Pencarian File
    - Mengunduh File
5. Mengunduh Folder di GitHub
    - Menangkap URL
    - Mengunduh Folder
6. Kode Proyek Lengkap (Pencarian Repositori)
7. Kode Proyek Lengkap (Pencarian File)
8. Kode Proyek Lengkap (Mengunduh Sebuah Folder)

Persiapan Proyek
Token Akses Personal

Untuk mengakses GitHub API, Anda akan memerlukan token akses untuk memberi otorisasi pada panggilan API. Silakan ikuti langkah-langkah berikut untuk mendapatkan token akses dari halaman pengaturan token GitHub. Jika Anda belum memiliki akun GitHub, Anda perlu membuat akun terlebih dahulu.

- Buka halaman GitHub dan masuk ke akun Anda.
- Klik pada foto profil Anda di pojok kanan atas halaman.
- Pilih "Settings" dari menu dropdown yang muncul.
- Di halaman pengaturan, pilih "Developer settings" di sidebar sebelah kiri.
- Pilih "Personal access tokens".
- Klik tombol "Generate new token".

![Generate Personal Access Token](/images/2023/github-api-generate-token.webp)

- Berikan deskripsi yang relevan untuk token Anda.
- Pilih cakupan (scopes) yang sesuai dengan kebutuhan Anda. Misalnya, jika Anda hanya melakukan pencarian, Anda mungkin perlu memilih cakupan "public_repo" atau "repo" tergantung pada apakah repositori yang ingin Anda cari adalah publik atau pribadi.

![Generate Personal Access Token Description](/images/2023/github-api-generate-token-description.webp)

- Gulir ke bawah dan klik tombol "Generate token".
- Salin token akses yang dihasilkan. Pastikan untuk menyimpannya dengan aman dan tidak membagikannya ke publik.

Token akses personal ini akan digunakan dalam kode Python Anda untuk mengotentikasi permintaan API ke GitHub. Pastikan untuk menjaga kerahasiaan token Anda dan tidak mengungkapkannya secara publik atau menyimpannya dalam repositori yang dapat diakses oleh orang lain.

Setelah token Anda dibuat, salin dan simpan di tempat yang aman untuk digunakan nanti. Perhatikan bahwa setelah Anda meninggalkan halaman ini, Anda tidak akan melihat token tersebut lagi.

Penting untuk menyimpan token akses dengan aman dan hanya menggunakan token tersebut dalam proyek Anda sendiri. Jangan pernah membagikan token akses kepada orang lain atau menyimpannya di tempat yang dapat diakses oleh pihak lain, karena ini dapat mengakibatkan penyalahgunaan atau akses yang tidak sah ke akun GitHub Anda.

Persiapan Klien

Satu-satunya paket yang perlu Anda instal untuk Python adalah PyGithub. Jalankan perintah berikut:

    pip install PyGithub

Catatan: PyGithub adalah pustaka pihak ketiga. GitHub hanya menyediakan pustaka klien resmi untuk Ruby, Node.js, dan .NET.

Kemudian, Anda perlu mengimpor pustaka tersebut.

    from github import Github

Uji GitHub API

Dengan token akses yang Anda peroleh sebelumnya, Anda perlu menguji koneksi ke API. Pertama-tama, buat konstanta untuk menyimpan token Anda:

    ACCESS_TOKEN = 'masukkan token Anda di sini'

Selanjutnya, inisialisasi klien GitHub.

    g = Github(ACCESS_TOKEN)

Anda dapat mencoba mendapatkan daftar repositori Anda untuk menguji koneksi.

    print(g.get_user().get_repos())

Hasilnya seharusnya menjadi sesuatu seperti berikut.

    <github.PaginatedList.PaginatedList object at ......>

Bagus. Sekarang Anda sudah siap.

Tutorial ini mencakup topik-topik berikut:

1. Pencarian repositori GitHub menggunakan GitHub API
2. Pencarian file *.po menggunakan GitHub API
3. Mengunduh folder dari GitHub menggunakan svn

Sebelum melanjutkan, buat salinan skrip dengan token akses sehingga Anda memiliki dua skrip terpisah untuk setiap bagian.


Mencari Repositori GitHub (Mengambil Kata Kunci)

Hal pertama yang perlu Anda lakukan adalah mengambil kata kunci. Cukup tambahkan potongan kode berikut di bagian akhir skrip Anda:

    if __name__ == '__main__':
        keywords = input('Enter keyword(s)[e.g python, flask, postgres]: ')

Anda dapat menambahkan kode ini di akhir skrip Anda untuk meminta pengguna memasukkan kata kunci. Pesan input memberikan contoh format untuk memasukkan kata kunci. Kemudian, kode tersebut membagi input menjadi sebuah daftar, menghapus spasi putih di sekitar kata kunci. Terakhir, kode tersebut memanggil fungsi search_github dengan kata kunci yang diperoleh.


Perhatikan saran yang ada di antara tanda kurung siku. Selalu baik untuk memberikan panduan kepada pengguna tentang jenis input yang Anda butuhkan agar Anda tidak perlu banyak waktu untuk memproses input yang diberikan.

Setelah pengguna memberikan input, Anda perlu membaginya menjadi sebuah daftar:

    keywords = [keyword.strip() for keyword in keywords.split(',')]

Di sini, Anda membagi kata kunci yang diberikan dan menghapus spasi yang tidak perlu. Pemahaman daftar (list comprehension : https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions) Python memungkinkan Anda melakukan semua ini dalam satu baris.


Pencarian Repositori

Sekarang Anda perlu menambahkan sebuah fungsi yang akan menerima kata kunci dan mencari repositori di GitHub yang cocok.

    def search_github(keywords):
        query = '+'.join(keywords) + '+in:readme+in:description'
        result = g.search_repositories(query, 'stars', 'desc')
    
        print(f'Found {result.totalCount} repo(s)')
    
        for repo in result:
            print(repo.clone_url)

Ada beberapa hal yang terjadi dalam fungsi ini. Pertama, Anda mengambil kata kunci dan membentuk sebuah query pencarian GitHub. Query pencarian GitHub memiliki format berikut.

    SEARCH_KEYWORD_1+SEARCH_KEYWORD_N+QUALIFIER_1+QUALIFIER_N

Dalam fungsi tersebut, '+in:readme+in:description' adalah qualifier. Setelah query terbentuk, Anda mengirimkan query tersebut ke GitHub dengan mengurutkan hasil berdasarkan jumlah bintang secara menurun. Setelah Anda mendapatkan hasilnya, Anda mencetak jumlah total repositori yang ditemukan dan kemudian mencetak URL kloning untuk masing-masing repositori. Pada bagian akhir skrip Anda, tambahkan pemanggilan fungsi dengan parameter kata kunci dan jalankan skrip.

    keywords = [keyword.strip() for keyword in keywords.split(',')]
    search_github(keywords)

Ketika Anda mengirimkan python, django, postgres sebagai input ke dalam skrip, Anda akan 

mendapatkan output berikut:

    Found 10 repo(s)
    https://github.com/django/django.git
    https://github.com/pallets/flask.git
    https://github.com/psycopg/psycopg2.git
    https://github.com/psycopg/psycopg2-binary.git
    https://github.com/tornadoweb/tornado.git
    https://github.com/python-pillow/Pillow.git
    https://github.com/python/mypy.git
    https://github.com/encode/httpx.git
    https://github.com/coleifer/peewee.git
    https://github.com/encode/orm.git

Ini adalah contoh output yang dihasilkan oleh skrip jika Anda menggunakan python, django, postgres sebagai input. Anda akan melihat jumlah total repositori yang ditemukan, diikuti oleh URL kloning untuk setiap repositori.

Untuk membuat output lebih dapat digunakan, Anda perlu menambahkan jumlah bintang (stars) di samping setiap URL. Berikut adalah modifikasi yang perlu dilakukan:

    for repo in result:
        print(f'{repo.clone_url}, {repo.stargazers_count} stars')

Output ini akan mencantumkan URL setiap repositori diikuti oleh jumlah bintang (stars) yang diberikan.

    Found 54 repo(s)
    https://github.com/citusdata/django-multitenant.git, 181 stars
    https://github.com/dheerajchand/ubuntu-django-nginx-ansible.git, 15 stars
    https://github.com/chenjr0719/Docker-Django-Nginx-Postgres.git, 6 stars
    https://github.com/nomadjourney/python-box.git, 4 stars
    https://github.com/laitassou/etherkar.git, 2 stars
    https://github.com/the-vampiire/medi_assessment.git, 2 stars
    https://github.com/mapes911/django-vagrant-box.git, 1 stars
    https://github.com/sathyaNarayanC/registration-form.git, 1 stars
    https://github.com/dxvxd/vagrant-py3-django-pgSQL.git, 1 stars
    https://github.com/joshimiloni/AAM-Book-Exchange.git, 1 stars
    https://github.com/desarroll0/lostItems.git, 1 stars
    .....

Pencarian Repositori di GitHub

Dalam bagian ini, Anda akan mencari berkas *.po (berkas terjemahan) yang mencakup nama bahasa tertentu.

Mengambil Kata Kunci

Hal pertama yang perlu Anda lakukan adalah mengambil kata kunci. Cukup tambahkan potongan kode berikut di bagian bawah skrip Anda:

    if __name__ == '__main__':
        keyword = input('Enter keyword[e.g french, german etc]: ')

Kode ini akan meminta pengguna untuk memasukkan kata kunci untuk mencari berkas di GitHub.

Perhatikan saran-saran di antara tanda kurung siku. Selalu baik untuk memberikan panduan kepada pengguna tentang jenis input yang Anda perlukan sehingga Anda tidak menghabiskan banyak waktu untuk mengurai input yang diberikan.

Pencarian File

Sekarang Anda perlu menambahkan sebuah fungsi yang akan menerima kata kunci dan mencari file-file di GitHub yang mengandungnya. Berikut adalah kode untuk fungsi tersebut:

    def search_github(keyword):
        rate_limit = g.get_rate_limit()
        rate = rate_limit.search
        if rate.remaining == 0:
            print(f'You have 0/{rate.limit} API calls remaining. Reset time: {rate.reset}')
            return
        else:
            print(f'You have {rate.remaining}/{rate.limit} API calls remaining')

        query = f'"{keyword} english" in:file extension:po'
        result = g.search_code(query, order='desc')

        max_size = 100
        print(f'Found {result.totalCount} file(s)')
        if result.totalCount > max_size:
            result = result[:max_size]

        for file in result:
            print(f'{file.download_url}')

Ada beberapa hal yang terjadi dalam fungsi ini. Pertama, Anda memeriksa batas tingkat API saat ini di GitHub. Untuk mencegah pemblokiran panggilan API di masa depan, selalu baik untuk memeriksa status batas Anda sebelum melakukan panggilan apa pun. Jika tingkat Anda memenuhi syarat, Anda mengambil kata kunci dan membentuk kueri pencarian GitHub.

Dalam fungsi Anda, 'in:file extension:po' adalah kualifikasi. Anda hanya tertarik pada file *.po yang mengandung kata kunci Anda. Perhatikan juga variabel max_size. Ini digunakan untuk membatasi hasil yang dikembalikan hingga 100 pertama. Setelah kueri terbentuk, Anda mengirimkan kueri tersebut ke GitHub dengan mengurutkan hasil secara menurun. Ketika Anda mendapatkan hasilnya, Anda mencetak jumlah total file yang ditemukan dan kemudian mencetak URL unduhan untuk masing-masing file. Di bagian bawah skrip Anda, tambahkan pemanggilan fungsi dengan kata kunci sebagai parameter dan jalankan skripnya.

    ....
    search_github(keywords)

Ketika Anda mengirimkan "dutch" sebagai masukan ke skrip, Anda seharusnya mendapatkan keluaran berikut.

    You have 28/30 API calls remaining
    Found 196 file(s)
    https://raw.githubusercontent.com/iegor/kdesktop/d5dccbe01eeb7c0e82ac5647cf2bc2d4c7beda0b/kde-i18n/ar/messages/kdeedu/klettres.po
    https://raw.githubusercontent.com/iegor/kdesktop/d5dccbe01eeb7c0e82ac5647cf2bc2d4c7beda0b/kde-i18n/en_GB/messages/kdeedu/klettres.po
    https://raw.githubusercontent.com/iegor/kdei18n/d5c80ababe3d6a39dcde39605080ddf07856215e/en_GB/messages/kdeedu/klettres.po
    https://raw.githubusercontent.com/iegor/kdei18n/d5c80ababe3d6a39dcde39605080ddf07856215e/ar/messages/kdeedu/klettres.po
    https://raw.githubusercontent.com/iegor/kdesktop/d5dccbe01eeb7c0e82ac5647cf2bc2d4c7beda0b/kde-i18n/af/messages/kdeedu/klettres.po
    https://raw.githubusercontent.com/iegor/kdesktop/d5dccbe01eeb7c0e82ac5647cf2bc2d4c7beda0b/kde-i18n/az/messages/kdeedu/klettres.po
    https://raw.githubusercontent.com/iegor/kdesktop/d5dccbe01eeb7c0e82ac5647cf2bc2d4c7beda0b/kde-i18n/br/messages/kdeedu/klettres.po
    https://raw.githubusercontent.com/iegor/kdesktop/d5dccbe01eeb7c0e82ac5647cf2bc2d4c7beda0b/kde-i18n/bs/messages/kdeedu/klettres.po
    https://raw.githubusercontent.com/iegor/kdesktop/d5dccbe01eeb7c0e82ac5647cf2bc2d4c7beda0b/kde-i18n/cy/messages/kdeedu/klettres.po
    ..........

Mengunduh File

Untuk mengunduh file yang dihasilkan dari skrip sebelumnya, Anda dapat menggunakan pustaka Requests.


    import requests

    url = "https://raw.githubusercontent.com/iegor/kdesktop/d5dccbe01eeb7c0e82ac5647cf2bc2d4c7beda0b/kde-i18n/ar/messages/kdeedu/klettres.po"

    r = requests.get(url)

    open("file.po", "wb").write(r.content)

Setelah mengimpor requests, baris pertama adalah URL file yang sederhana. Baris kedua mengirim permintaan untuk terhubung ke URL tersebut. Terakhir, baris terakhir menulis konten file ke file baru di mesin lokal.

Anda dapat menambahkan bagian kode ini ke dalam loop for file in result yang telah Anda buat. Dalam hal ini, Anda perlu membedakan nama file, mungkin dengan nomor indeksnya dalam loop atau dengan menggunakan filename = url[url.rfind("/")+1:] untuk mengekstrak nama file dari URL.

Mengunduh Folder di GitHub

Pada bagian ketiga tutorial ini, Anda akan belajar cara mengunduh satu folder/direktori dari repositori GitHub. Harap dicatat bahwa bagian ini tidak memerlukan penggunaan API GitHub, jadi cukup buat skrip Python kosong.

Menangkap URL

Hal pertama yang perlu Anda lakukan adalah menangkap URL dari folder yang ingin Anda unduh. Pada skrip kedua yang telah Anda buat sebelumnya, tambahkan yang berikut.

    url = input('Enter folder url: ')

Ketika berurusan dengan URL, selalu baik untuk memvalidasi mereka sebelum melakukan apapun dengannya. Ada beberapa metode untuk melakukannya. Untuk tutorial ini, Anda akan menggunakan sebuah perpustakaan yang berfokus pada validasi. Jalankan:

    pip install validators

Setelah Anda menginstal paketnya, tambahkan logika validasi di bagian bawah skrip.

    import validators

    ....
    if not validators.url(url):
        print('Invalid url')
    else:
        pass

Sebelum menambahkan fungsi untuk mengunduh folder, Anda perlu menambahkan satu dependensi lagi.

    pip install svn

SVN (Subversion) adalah sistem kontrol versi terpusat, seperti git. Git tidak memiliki perintah bawaan untuk mengunduh sub-direktori dari repositori. Satu-satunya cara untuk mendapatkan semua file dari sub-direktori adalah dengan mengunduh file-file tersebut secara individu. Hal ini bisa sangat melelahkan, dan itulah alasan mengapa kita menggunakan svn.

Catatan: Agar paket SVN Python dapat berfungsi, pastikan svn terpasang di sistem Anda dan dapat dijalankan melalui Terminal/Command Prompt.

Mengunduh Folder

Setelah Anda memverifikasi bahwa svn terpasang, tambahkan fungsi untuk mengunduh folder. Berikut adalah contoh kode yang dapat Anda gunakan:

    from svn.remote import RemoteClient
    ....

    def download_folder(url):
        if 'tree/master' in url:
            url = url.replace('tree/master', 'trunk')

        r = RemoteClient(url)
        r.export('output')

Untuk membuat svn berfungsi dengan URL yang diberikan, Anda perlu mengganti "tree/master" dengan "trunk". Git dan svn memiliki banyak fitur yang sama, tetapi juga memiliki banyak perbedaan, dan pola URL adalah salah satunya.

Terakhir, tambahkan fungsi berikut di bagian bawah skrip:

    if not validators.url(url):
        print('Invalid url')
    else:
        download_folder(url)

Sekarang, coba jalankan skrip tersebut dengan menyediakan URL https://github.com/pallets/flask/tree/master/examples. Sebuah folder bernama "output" akan dibuat dengan konten dari folder yang ditentukan dalam URL tersebut.

Kode Proyek Lengkap (Pencarian Repositori)

    from github import Github

    ACCESS_TOKEN = 'put your token here'

    g = Github(ACCESS_TOKEN)


    def search_github(keywords):
        query = '+'.join(keywords) + '+in:readme+in:description'
        result = g.search_repositories(query, 'stars', 'desc')

        print(f'Found {result.totalCount} repo(s)')

        for repo in result:
            print(f'{repo.clone_url}, {repo.stargazers_count} stars')


    if __name__ == '__main__':
        keywords = input('Enter keyword(s)[e.g python, flask, postgres]: ')
        keywords = [keyword.strip() for keyword in keywords.split(',')]
        search_github(keywords)


Kode Proyek Lengkap (Pencarian File)

    from github import Github

    ACCESS_TOKEN = 'put your token hear'

    g = Github(ACCESS_TOKEN)

    def search_github(keyword):
        rate_limit = g.get_rate_limit()
        rate = rate_limit.search
        if rate.remaining == 0:
            print(f'You have 0/{rate.limit} API calls remaining. Reset time: {rate.reset}')
            return
        else:
            print(f'You have {rate.remaining}/{rate.limit} API calls remaining')

        query = f'"{keyword} english" in:file extension:po'
        result = g.search_code(query, order='desc')

        max_size = 100
        print(f'Found {result.totalCount} file(s)')
        if result.totalCount > max_size:
            result = result[:max_size]

        for file in result:
            print(f'{file.download_url}')


    if __name__ == '__main__':
        keyword = input('Enter keyword[e.g french, german etc]: ')
        search_github(keyword)


Kode Proyek Lengkap (Mengunduh Sebuah Folder)

    import validators

    from svn.remote import RemoteClient

    def download_folder(url):
        if 'tree/master' in url:
            url = url.replace('tree/master', 'trunk')

        r = RemoteClient(url)
        r.export('output')
        

    if __name__ == '__main__':
        url = input('Enter folder url: ')
        if not validators.url(url):
            print('Invalid url')
        else:
            download_folder(url)

Pencarian Dengan Pagination (Bonus)

    import requests
    import time

    headers = {
    'Authorization': 'token <YOUR_TOKEN>'
    }

    results = []
    min_max = (1,31)
    for i in range(min_max[0], min_max[1]):
        url = "https://api.github.com/search/code?q='pytorch'+in:file + language:python&per_page=10&page="+str(i)
        backoff = 2 # backoff in seconds
        while backoff < 1024:
            time.sleep(backoff)
            try:
                response = requests.request("GET", url, headers=headers)
                response.raise_for_status() # throw an exception for HTTP 400 and 500s
                data = response.json()
                results.append(data['items'])
                print(f'Got {len(data["items"])} results for page {i}.')
                url = response.links['next']['url']
                # Save results to a text file
                with open('search_results.txt', 'w') as file:
                    for item in results:
                        print(item[0]['html_url'])
                        file.write(str(item[0]['html_url']) + '\n')
                break
            except requests.exceptions.RequestException as e:
                print('ERROR: Failed to make request: ', e)
                backoff **= 2
        if backoff >= 1024:
            print('ERROR: Backoff limit reached.')
            break

Refferensi : 
- https://python.gotrained.com/search-github-api/
- https://stackoverflow.com/questions/74869773/how-do-i-get-all-1000-results-using-the-github-search-api