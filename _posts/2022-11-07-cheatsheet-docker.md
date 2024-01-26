---
layout: post
title: Kumpulan Cheatsheet Docker
modified: 2022-11-7T20:00:28+07:00
categories:
description: "Kumpulan Cheatsheet Docker"
tags: [docker, docker compose]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-7T17:00:28+07:00
---

{% highlight bash %}

# add user to docker group
sudo usermod -aG docker $USER

# get access to group in current shell
newgrp docker

# Docker copy
docker cp container_name:/src_path dest_path

# Docker Tips: Clean Up Your Local Machine
- docker file system
docker system df 
- Clean build cache
docker builder prune

- Image prune 
docker image prune

- system prune
docker system prune 

- find img file docker
find /var/lib/docker -type f -name test.img

- Historical command
docker rm -f $(docker ps -aq)

- More recent command
docker container rm -f $(docker container ls -aq)

- Cleanup exited processes:
docker rm $(docker ps -q -f status=exited)

- Cleanup dangling volumes:
docker volume rm $(docker volume ls -qf dangling=true)

- Cleanup dangling or None images:
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker rmi $(docker images -a|grep "<none>"|awk '$1=="<none>" {print $3}')

- Docker run with bash
docker run --rm -it --entrypoint bash <image_or_id>
docker exec -it <container-name-or-id> bash

- Docker Inspect (All)
docker inspect <container_name_or_id>

- Docker Inspect (Only Command)
docker inspect --format="{.Config.Cmd}" <container_name_or_id>

- Docker Scan Vuln
docker scout quickview <images>

- Check ip range on docker network list
for name in  $(docker network ls --format '{{.Name}}' ) ; do echo $name ; docker inspect $name --format '{{ .IPAM.Config }}' ; done

# Referensi : 
https://github.com/wsargent/docker-cheat-sheet

{% endhighlight %}