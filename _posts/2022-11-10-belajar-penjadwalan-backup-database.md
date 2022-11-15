---
layout: post
title: Belajar penjadwalan backup database
description: "Belajar penjadwalan backup database"
tags: [cheatsheet, cronjobs, backup database]
image:
  background: triangular.png
---

{% highlight bash %} 

1. Buat File /home/user/backup.sh

isikan seperti dibawah ini: 

#!/bin/bash

TODAY=`date +%d%m%Y`
FILE="dump_$TODAY.sql"

# Backup database (today)
mysqldump -v -h localhost --protocol=TCP -P 3306 -u your_user_db --compress --single-transaction --quick -pYourpassword db_name > /home/user/$FILE

sleep 5

# copy file backup awal bulan ke folder /home/user/bulan
if [[ $FILE == *"dump_01"* ]]; then
mv /home/user/$FILE /home/user/bulan/
fi

# hapus file backup 3 hari yang lalu
rm /home/user/dump_`date -d "3 day ago" +"%d%m%Y"`*

2. Lalu Simpan 
3. Buat Penjadwalan melalui crontab 
sudo crontab -e 
isikan : 
00 01 * * * /home/user/backup.sh
4. Simpan 
Penjadwalan backup database akan dilakukan pada jam 1 am

{% endhighlight %}