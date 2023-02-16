---
layout: post
title: Cara Download Google Drive Menggunakan Wget
modified: 2023-02-17T17:00:28+07:00
categories:
description: "Cara Download Google Drive Menggunakan Wget"
tags: [google drive, drive, download]
image:
  background: triangular.png
comments: true
share: true
date: 2023-02-17T17:00:28+07:00
---

Salin link tautan untuk berbagi misal
{% highlight bash %} 
https://drive.google.com/file/d/1UibyVC_C2hoT_XEw15gPEwPW4yFyJFKaSs/view?usp=sharing
{% endhighlight %}

Ekstraksi bagian UNIKID link google drive
{% highlight bash %} 

1UibyVC_C2hoT_XEw15gPEwPW4yFyJFKaSs
{% endhighlight %}

Jika file yang diunduh berukuran kecil jalankan perintah berikut di terminal:

{% highlight bash %} 
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=UNIKID' -O FILENAME
{% endhighlight %}

ubahlah UNIKID dengan id di atas diekstraksi dan ganti nama FILENAME untuk penggunaan mudah Anda sendiri.
Untuk file lagre jalankan perintah berikut dengan perubahan yang diperlukan dalam UNIKID dan FILENAME:

{% highlight bash %} 

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=UNIKID' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=UNIKID" -O FILENAME && rm -rf /tmp/cookies.txt

{% endhighlight %}
