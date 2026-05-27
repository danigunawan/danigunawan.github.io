---
layout: post
title: Fix Samba Share Error After Windows 11 24H2 Update
modified: 2026-02-17T12:00:00+07:00
categories:
description: "Mengatasi error Samba share setelah update Windows 11 24H2 yang memblokir guest access."
tags: [windows 11, samba, smb, networking, powershell]
image:
  path: /images/posts/default.png
comments: true
share: true
date: 2026-02-17T12:00:00+07:00
---

Setelah melakukan update **Windows 11 versi 24H2**, Samba share yang sebelumnya dapat diakses tanpa autentikasi tiba-tiba tidak dapat diakses dan meminta login.

Pesan error yang muncul:

> You canâ€™t access this shared folder because your organizationâ€™s security policies block unauthenticated guest accessâ€¦

Hal ini terjadi karena Windows 11 24H2 menerapkan kebijakan keamanan SMB yang lebih ketat, termasuk memblokir akses guest tanpa autentikasi.

---

## Solusi

Buka **PowerShell sebagai Administrator**, lalu jalankan perintah berikut:

{% highlight powershell %}

Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
Set-SmbClientConfiguration -RequireSecuritySignature $false -Force
Set-SmbServerConfiguration -RequireSecuritySignature $false -Force

{% endhighlight %}

---

## Penjelasan Perintah

1. **EnableInsecureGuestLogons**
   - Mengaktifkan kembali akses guest (tanpa autentikasi) pada SMB client.

2. **RequireSecuritySignature (Client)**
   - Menonaktifkan kewajiban SMB signing pada sisi client.

3. **RequireSecuritySignature (Server)**
   - Menonaktifkan kewajiban SMB signing pada sisi server.

---

## Catatan Keamanan

Mengaktifkan insecure guest logon akan menurunkan tingkat keamanan sistem.

Disarankan hanya digunakan pada:
- Jaringan lokal terpercaya (LAN)
- Environment lab / development
- Home server

Untuk environment production atau enterprise, lebih disarankan:
- Menggunakan autentikasi user pada Samba
- Mengaktifkan SMB signing
- Mengatur permission share dengan benar

---

## Kesimpulan

Windows 11 24H2 secara default memblokir akses SMB guest tanpa autentikasi.  
Dengan mengaktifkan kembali insecure guest logon melalui PowerShell, Samba share dapat diakses kembali seperti sebelumnya.

