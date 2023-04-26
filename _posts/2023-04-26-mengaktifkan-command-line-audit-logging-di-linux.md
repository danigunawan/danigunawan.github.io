---
layout: post
title: Mengaktifkan Command Line(CLI) Audit Logging Di Linux
modified: 2023-04-26T17:00:28+07:00
categories:
description: "Mengaktifkan Command Line(CLI) Audit Logging Di Linux"
tags: [audit, logging]
image:
  background: triangular.png
comments: true
share: true
date: 2023-04-26T17:00:28+07:00
---

Masuk dan Login ssh dengan menggunakan root akses

    sudo su - 

Ubah /etc/profile dan tambahkan baris berikut ke bagian bawah file /etc/profile:

    # command line audit logging
    function log2syslog
    {
       declare COMMAND
       COMMAND=$(fc -ln -0)
       logger -p local1.notice -t bash -i -- "${USER}:${COMMAND}"
    }
    trap log2syslog DEBUG

Simpan dan keluar /etc/profile

Ubah /etc/rsyslog.conf dan tambahkan baris berikut ke bagian bawah file:

    # command line audit logging
    local1.* -/var/log/cmdline

Save dan keluar /etc/rsyslog.conf 

Restart service rsyslog, atau mulai ulang seluruh mesin untuk agar bisa memuat ulang bash profil dan memberlakukan perubahan.

    /etc/init.d/rsyslog restart

Logging audit akan terlihat di bawah /var/log/syslog dan /var/log/cmdline.

    cat /var/log/syslog atau cat /var/log/cmdline 

akan terlihat seperti ini:

    Aug 22 15:04:39 ip-10-10-34-56 bash[15856]: jsmith:
    Aug 22 15:04:40 ip-10-10-34-56 bash[15859]: jsmith:#011 sudo su -
    Aug 22 15:04:43 ip-10-10-34-56 bash[15893]: root:
    Aug 22 15:04:49 ip-10-10-34-56 bash[15903]: root:#011 ls -lart /var/log
    Aug 22 15:05:01 ip-10-10-34-56 CRON[15927]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
    Aug 22 15:05:06 ip-10-10-34-56 bash[15937]: root:#011 ls -lart /var/log | grep cmd
    Aug 22 15:15:01 ip-10-10-34-56 CRON[17254]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
    Aug 22 15:17:01 ip-10-10-34-56 CRON[17513]: (root) CMD (   cd / && run-parts --report /etc/cron.hourly)
    Aug 22 15:20:02 ip-10-10-34-56 bash[17921]: root:#011 cd /var/log
    Aug 22 15:20:03 ip-10-10-34-56 bash[17924]: root:#011 ls
    Aug 22 15:20:16 ip-10-10-34-56 bash[17969]: root:#011 service confluence restart
    Aug 22 15:20:16 ip-10-10-34-56 systemd[1]: Stopping SYSV: Confluence...
    Aug 22 15:20:16 ip-10-10-34-56 confluence[17975]: Stopping confluence
    Aug 22 15:20:16 ip-10-10-34-56 systemd[1]: Started Session c8 of user confluence.
    Aug 22 15:20:27 ip-10-10-34-56 confluence[17975]: confluence stopped successfully
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Stopped SYSV: Confluence.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Starting SYSV: Confluence...
    Aug 22 15:20:27 ip-10-10-34-56 confluence[18103]: Starting confluence
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Stopping User Manager for UID 1300...
    Aug 22 15:20:27 ip-10-10-34-56 systemd[20231]: Stopped target Default.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[20231]: Stopped target Basic System.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[20231]: Stopped target Paths.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[20231]: Stopped target Timers.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[20231]: Reached target Shutdown.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[20231]: Starting Exit the Session...
    Aug 22 15:20:27 ip-10-10-34-56 systemd[20231]: Stopped target Sockets.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[20231]: Received SIGRTMIN+24 from PID 18107 (kill).
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Stopped User Manager for UID 1300.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Removed slice User Slice of confluence.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Created slice User Slice of confluence.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Starting User Manager for UID 1300...
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Started Session c9 of user confluence.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[18113]: Reached target Paths.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[18113]: Reached target Timers.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[18113]: Reached target Sockets.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[18113]: Reached target Basic System.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[18113]: Reached target Default.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[18113]: Startup finished in 9ms.
    Aug 22 15:20:27 ip-10-10-34-56 systemd[1]: Started User Manager for UID 1300.
    Aug 22 15:20:28 ip-10-10-34-56 systemd[1]: Started SYSV: Confluence.
    Aug 22 15:20:41 ip-10-10-34-56 bash[18207]: root:#011 ls
    Aug 22 15:20:54 ip-10-10-34-56 bash[18271]: root:#011 less syslog

Anda dapat menyimpan log pada NFS dan atau log syslog ke komputer lain.

