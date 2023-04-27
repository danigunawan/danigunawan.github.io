---
layout: post
title: Linux Better Command History
modified: 2023-04-26T17:00:28+07:00
categories:
description: "Linux Better Command History"
tags: [audit, logging]
image:
  background: triangular.png
comments: true
share: true
date: 2023-04-26T17:00:28+07:00
---

riwayat baris perintah yang lebih friendly, lebih banyak perintah yang disimpan, agregat, tambahkan informasi datetime.

tambahkan di /etc/profile
    
    # lihat format 'tanggal' untuk format waktu lainnya

    shopt -s histappend
    HISTSIZE=10000
    HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
    HISTCONTROL=ignoredups
    PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

exit & save lalu test setelah login ssh :

    history | less