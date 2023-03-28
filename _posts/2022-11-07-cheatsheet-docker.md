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

# add user to docker group
sudo usermod -aG docker $USER

# get access to group in current shell
newgrp docker

# Docker copy
docker cp container_name:/src_path dest_path

# Remove all image None
docker rmi $(docker images -a|grep "<none>"|awk '$1=="<none>" {print $3}')

# Referensi : 
https://github.com/wsargent/docker-cheat-sheet