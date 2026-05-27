---
layout: post
title: "Dokumentasi Lengkap Docker WSL2 ke G:\\WSL"
description: "Panduan lengkap mengenai backup, recovery, pemindahan Docker WSL2 ke drive lain, cleanup, dan optimasi agar disk C tidak penuh."
date: 2026-05-27T14:11:32+07:00
categories: [DevOps, Docker]
tags: [docker, wsl2, windows, backup, optimasi]
---

Dokumentasi ini mencakup:

- Backup
- Recovery
- Pindah Docker WSL2 ke `G:\WSL`
- Cleanup
- Compact size
- Preventif agar disk `C:` tidak penuh lagi

Untuk Docker Desktop dengan backend WSL2.

---

## 1. Struktur Folder yang Disarankan

Gunakan struktur berikut:

```text
G:\WSL\
├── backup\
├── docker-desktop-data\
├── temp\
└── ubuntu\
```

**Keterangan:**
- `backup` → backup TAR/VHDX
- `docker-desktop-data` → storage Docker aktif
- `temp` → file sementara
- `ubuntu` → distro Linux lain (opsional)

---

## 2. Lokasi Default Docker WSL

Secara default, Docker menyimpan data di:

```text
C:\Users\<user>\AppData\Local\Docker\wsl\disk\docker_data.vhdx
```

File ini berisi:
- Images
- Containers
- Volumes
- Build cache

---

## 3. Cek Status Docker WSL

**Cek distro:**
{% highlight powershell %}
wsl -l -v
{% endhighlight %}

Biasanya muncul:
- `docker-desktop`
- `docker-desktop-data`

**Cek ukuran VHDX:**
{% highlight powershell %}
Get-Item "$env:LOCALAPPDATA\Docker\wsl\disk\docker_data.vhdx" |
Select Name,@{Name="SizeGB";Expression={[math]::Round($_.Length/1GB,2)}}
{% endhighlight %}

**Cek penggunaan Docker:**
{% highlight powershell %}
docker system df
{% endhighlight %}

---

## 4. Backup Docker WSL (WAJIB)

**Tutup Docker Desktop**
Quit dari tray icon.

**Shutdown WSL:**
{% highlight powershell %}
wsl --shutdown
{% endhighlight %}

**Buat folder backup:**
{% highlight powershell %}
mkdir G:\WSL
mkdir G:\WSL\backup
{% endhighlight %}

---

## 5. Backup VHDX Manual (Paling Aman)

**Copy:**
Dari: `C:\Users\<user>\AppData\Local\Docker\wsl\disk\docker_data.vhdx`
Ke: `G:\WSL\backup\docker_data_backup.vhdx`

**PowerShell:**
{% highlight powershell %}
Copy-Item "$env:LOCALAPPDATA\Docker\wsl\disk\docker_data.vhdx" "G:\WSL\backup\docker_data_backup.vhdx"
{% endhighlight %}

> **⚠️ Penting:** Jangan eksperimen sebelum backup selesai.

---

## 6. Backup Resmi via Export

**Export Docker WSL:**
{% highlight powershell %}
wsl --export docker-desktop-data G:\WSL\backup\docker-desktop-data.tar
{% endhighlight %}

**Keuntungan:**
- Portable
- Aman
- Bisa di-import ulang

---

## 7. Recovery Jika Pernah Unregister

**Kondisi:**
Jika pernah menjalankan `wsl --unregister docker-desktop-data` tetapi file VHDX masih ada.

**Recovery Aman:**

1. **Rename VHDX lama:**
   Dari `docker_data.vhdx` menjadi `docker_data_backup.vhdx`

2. **Jalankan Docker Desktop:**
   Biarkan Docker membuat `docker-desktop` dan `docker-desktop-data` baru.

3. **Shutdown lagi:**
   {% highlight powershell %}
   wsl --shutdown
   {% endhighlight %}

4. **Replace disk baru:**
   Rename `docker_data.vhdx` menjadi `docker_data_new.vhdx`

5. **Copy backup lama kembali:**
   Ubah kembali `docker_data_backup.vhdx` menjadi `docker_data.vhdx`

6. **Jalankan Docker lagi dan test:**
   {% highlight powershell %}
   docker ps -a
   docker images
   {% endhighlight %}

---

## 8. Pindahkan Docker WSL ke G:\WSL

**Metode Aman (Recommended):**

1. **Shutdown:**
   {% highlight powershell %}
   wsl --shutdown
   {% endhighlight %}

2. **Export:**
   {% highlight powershell %}
   wsl --export docker-desktop-data G:\WSL\docker-desktop-data.tar
   {% endhighlight %}

3. **Unregister:**
   {% highlight powershell %}
   wsl --unregister docker-desktop-data
   {% endhighlight %}

4. **Import ke G:**
   {% highlight powershell %}
   wsl --import docker-desktop-data G:\WSL\docker-desktop-data G:\WSL\docker-desktop-data.tar --version 2
   {% endhighlight %}

5. **Jalankan Docker Desktop**

6. **Verifikasi:**
   {% highlight powershell %}
   wsl -l -v
   docker ps
   docker images
   {% endhighlight %}

---

## 9. Hapus File TAR Setelah Aman

{% highlight powershell %}
del G:\WSL\docker-desktop-data.tar
{% endhighlight %}

---

## 10. Mengecilkan Docker WSL

**Cleanup Docker:**

- **Aman standar:**
  {% highlight powershell %}
  docker system prune
  {% endhighlight %}

- **Cleanup agresif:**
  {% highlight powershell %}
  docker system prune -a
  {% endhighlight %}

- **Cleanup volume:**
  {% highlight powershell %}
  docker system prune -a --volumes
  {% endhighlight %}
  > **⚠️ Hati-hati:** Database dan persistent storage bisa terhapus.

- **Cleanup build cache:**
  {% highlight powershell %}
  docker builder prune -a
  {% endhighlight %}

---

## 11. Compact VHDX

1. **Shutdown:**
   {% highlight powershell %}
   wsl --shutdown
   {% endhighlight %}

2. **Compact modern:**
   {% highlight powershell %}
   Optimize-VHD -Path "G:\WSL\docker-desktop-data\ext4.vhdx" -Mode Full
   {% endhighlight %}

3. **Jika Optimize-VHD tidak ada, jalankan:**
   {% highlight powershell %}
   diskpart
   {% endhighlight %}
   Lalu di dalam `diskpart`:
   {% highlight text %}
   select vdisk file="G:\WSL\docker-desktop-data\ext4.vhdx"
   attach vdisk readonly
   compact vdisk
   detach vdisk
   exit
   {% endhighlight %}

---

## 12. Preventif Agar Disk Tidak Cepat Penuh

**A. Simpan Docker di G:\WSL**
Jangan di drive `C:`.

**B. Hindari Dataset di Volume Docker**
- ❌ **Buruk:** `docker volume create dataset`
- ✅ **Lebih baik:** `-v G:\dataset:/dataset`

**C. Cleanup Rutin**
Seminggu sekali:
{% highlight powershell %}
docker system prune -a
docker builder prune -a
{% endhighlight %}

**D. Hindari Banyak CUDA Image Lama**
- **Cek:** `docker image ls`
- **Hapus:** `docker rmi IMAGE_ID`

**E. Gunakan `.dockerignore`**
Contoh `.dockerignore`:
```text
node_modules
.git
dataset
logs
cache
```

---

## 13. Checklist Aman Sebelum Eksperimen

**SELALU:**
- ✅ `wsl --shutdown`
- ✅ Backup dulu
- ✅ Copy VHDX penting
- ✅ Cek free space
- ✅ Test `docker ps` setelah recovery

**JANGAN:**
- ❌ Delete `.vhdx` langsung
- ❌ Unregister tanpa backup
- ❌ Compact saat Docker aktif
- ❌ Force close Docker saat export/import

---

## 14. Command Penting Ringkas

- **Cek distro:**
  {% highlight powershell %}
  wsl -l -v
  {% endhighlight %}
- **Shutdown:**
  {% highlight powershell %}
  wsl --shutdown
  {% endhighlight %}
- **Export:**
  {% highlight powershell %}
  wsl --export docker-desktop-data G:\WSL\backup.tar
  {% endhighlight %}
- **Import:**
  {% highlight powershell %}
  wsl --import docker-desktop-data G:\WSL\docker-desktop-data G:\WSL\backup.tar --version 2
  {% endhighlight %}
- **Cleanup:**
  {% highlight powershell %}
  docker system prune -a
  {% endhighlight %}
- **Compact:**
  {% highlight powershell %}
  Optimize-VHD -Path "G:\WSL\docker-desktop-data\ext4.vhdx" -Mode Full
  {% endhighlight %}
