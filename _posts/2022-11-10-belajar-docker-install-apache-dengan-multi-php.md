---
layout: post
title: Belajar docker install apache dengan multiple php version
description: "Belajar docker install apache dengan multiple php version"
tags: [php, apache, dockerize, docker, multiple php version]
image:
  background: triangular.png
---
Beberapa versi php dalam container 
Versi PHP yang disupport : 
- 5.6
- 7.0
- 7.2
- 7.3
- 7.4
- 8.1

Struktur Code : 
- Apps/ : adalah folder apps 
- bin/ : terdapat setup dan binary untuk menjalankan dan mendukung php container seperti setup ssh, build image docker php version, dan lain-lain
- config/ : berisi konfigurasi
- .gitignore : file gitignore untuk memfilter yang akan di push pada repository
- Dockerfile-5.6 : File Dockerize PHP5.6
- Dockerfile-7.0 : File Dockerize PHP7.0
- Dockerfile-7.2 : File Dockerize PHP7.2
- Dockerfile-7.3 : File Dockerize PHP7.3
- Dockerfile-7.4 : File Dockerize PHP7.4
- Dockerfile-8.1 : File Dockerize PHP8.1
- Dockerfile-ssh : File Dockerize SSH
- docker-compose.yaml : File Docker Compose 

User yang digunakan untuk uid dan gid :

bin/builder.sh [optional:version]

Runing

{% highlight bash %} 
bin/run.sh [version]
ARGS_FILE=custom-file bin/run 5.6

{% endhighlight %}

Untuk menambahkan host tambahan, cukup perbarui config/hosts.yml

Juga akses ssh untuk aplikasi, lihat config/ssh-users untuk mengatur akses pengguna di sana.

{% highlight bash %} 
bin/setup_ssh.sh

untuk menyiapkan wadah ssh dengan pengguna

{% endhighlight %}

File cron ada di config/cron 

## Docker-compose
Untuk menguji dengan docker-compose run

{% highlight bash %} 
VERSION=8.1 docker-compose run --service-ports app
{% endhighlight %}

Kemudian masuk ke dalam container dengan perintah 

{% highlight bash %} 
docker exec -it nama kontainer /bin/sh

{% endhighlight %}

Lalu set akses folder owner dan coba menjalankan aplikasi melalui composer :

{% highlight bash %} 
chown apache-user /var/www/apps/test

su - apache-user

cd /var/www/apps/test

composer create-project --prefer-dist laravel/lumen .

{% endhighlight %}
