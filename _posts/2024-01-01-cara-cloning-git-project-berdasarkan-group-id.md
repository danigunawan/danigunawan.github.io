---
layout: post
title: Cara Cloning Git Projet Berdasarkan Group ID
modified: 2024-01-01T17:00:28+07:00
categories:
description: "Cara Cloning Git Projet Berdasarkan Group ID"
tags: [git, gitlab, github]
image:
  background: triangular.png
comments: true
share: true
date: 2024-01-01T17:00:28+07:00
---

{% highlight bash %} 

import requests
import subprocess
import shlex
import os
import urllib3
from tqdm import tqdm  # Impor tqdm untuk bar kemajuan

# Sembunyikan peringatan URL browser web
urllib3.disable_warnings()

def clone_repository(ssh_url, destination):
    # Pisahkan perintah Git clone menjadi daftar
    command = shlex.split(f"git clone --progress {ssh_url} {destination}")
    # Jalankan perintah Git clone menggunakan subprocess
    subprocess.Popen(command).communicate()

def pull_repository(destination):
    try:
        # Pisahkan perintah Git pull menjadi daftar
        command_pull = shlex.split("git pull --quiet --progress")
        # Jalankan perintah Git pull, bersihkan indeks, dan reset
        subprocess.Popen(command_pull, cwd=destination).communicate()
        
        # Bersihkan dan bangun kembali indeks
        command_clean_index = shlex.split("git clean -fdx")
        subprocess.Popen(command_clean_index, cwd=destination).communicate()

        command_reset = shlex.split("git reset --hard")
        subprocess.Popen(command_reset, cwd=destination).communicate()

    except Exception as e:
        print(f"Error saat pull: {e}")

def main():
    print("Program dimulai")
    # Data utama
    group_id = "ID_GROUP_PROJECT"  # ID grup GitLab
    gitlab_url = "https://gitlab.com"
    token = "YOUR_GIT_ACCESS_TOKEN"  # Token akses GitLab

    # Dapatkan direktori saat ini
    pathtodir = os.getcwd()

    print("Pencadangan dimulai ...")

    total_pages = 1
    page = 0
    while page < total_pages:
        page += 1

        # Dapatkan respons API dari GitLab
        response = requests.get(
            f"{gitlab_url}/api/v4/groups/{group_id}/projects?private_token={token}&include_subgroups=True&per_page=100&page={page}&with_shared=False", verify=False)
        
        for project in response.json():
            path = project['path_with_namespace']
            ssh_url_to_repo = project['ssh_url_to_repo']
            default_branch = project['default_branch']
            id = project['id']

            try:
                if not os.path.exists(path):
                    # Perulangan sub-cabang
                    total_pages_sousbranches = 1
                    page_sousbranches = 0

                    while page_sousbranches < total_pages_sousbranches:
                        page_sousbranches += 1

                        # Dapatkan respons API sub-cabang dari GitLab
                        response_sousbranches = requests.get(
                            f"{gitlab_url}/api/v4/projects/{id}/repository/branches?private_token={token}",
                            verify=False)

                        for project_sousbranches in tqdm(response_sousbranches.json(), desc=f"Mengklon {path}"):
                            name_sousbranches = project_sousbranches['name']
                            pathsousbranches = os.path.join(path, name_sousbranches)
                            clone_repository(ssh_url_to_repo, pathsousbranches)

                        total_pages_sousbranches = int(response_sousbranches.headers['X-Total-Pages'])
                else:
                    # Perulangan sub-cabang
                    total_pages_sousbranches = 1
                    page_sousbranches = 0

                    while page_sousbranches < total_pages_sousbranches:
                        page_sousbranches += 1

                        # Dapatkan respons API sub-cabang dari GitLab
                        response_sousbranches = requests.get(
                            f"{gitlab_url}/api/v4/projects/{id}/repository/branches?private_token={token}",
                            verify=False)

                        for project_sousbranches in tqdm(response_sousbranches.json(), desc=f"Menarik {path}"):
                            name_sousbranches = project_sousbranches['name']
                            pathsousbranches = os.path.join(path, name_sousbranches)
                            os.chdir(pathsousbranches)
                            pull_repository(pathsousbranches)

                        total_pages_sousbranches = int(response_sousbranches.headers['X-Total-Pages'])
            except Exception as e:
                print(f"{e}")

        total_pages = int(response.headers['X-Total-Pages'])

if __name__ == '__main__':
    main()

{% endhighlight %}


Skrip tersebut adalah alat otomatis untuk mengelola pencadangan (backup) repositori GitLab dan melakukan sinkronisasi dengan repositori yang ada. Berikut adalah penjelasan lebih rinci:

1. **Import Library:**
   - `requests`: Digunakan untuk berkomunikasi dengan API GitLab dan mendapatkan informasi proyek.
   - `subprocess`: Digunakan untuk menjalankan perintah Git dari dalam skrip.
   - `shlex`: Digunakan untuk mengurai dan memformat string perintah ke dalam bentuk yang dapat dijalankan oleh `subprocess`.
   - `os`: Memberikan fungsi-fungsi untuk berinteraksi dengan sistem operasi, dalam hal ini untuk mengelola direktori.
   - `urllib3`: Diperlukan untuk menonaktifkan peringatan SSL agar tidak muncul pesan peringatan yang mengganggu.
   - `tqdm`: Digunakan untuk menampilkan bar kemajuan (progress bar) agar pengguna dapat melihat kemajuan saat skrip berjalan.

2. **Fungsi `clone_repository` dan `pull_repository`:**
   - `clone_repository`: Mengklon repositori Git ke dalam direktori tujuan.
   - `pull_repository`: Menarik pembaruan terbaru dari repositori Git yang sudah ada, termasuk membersihkan dan mengatur ulang indeks.

3. **Fungsi Utama (`main`):**
   - Menyiapkan parameter utama seperti ID grup GitLab, URL GitLab, dan token akses.
   - Mengakses API GitLab untuk mendapatkan informasi proyek-proyek dalam grup tersebut.
   - Iterasi melalui setiap proyek, kemudian mengklon atau menarik pembaruan dari repositori dan sub-cabangnya.
   - Menampilkan bar kemajuan untuk memberikan visualisasi proses.

Skrip ini berguna terutama untuk situasi di mana perlu melakukan backup secara berkala atau mengelola repositori GitLab secara otomatis. Dengan skrip ini, pengguna dapat dengan mudah membuat cadangan atau menyinkronkan repositori dan sub-cabangnya tanpa harus melakukannya secara manual.