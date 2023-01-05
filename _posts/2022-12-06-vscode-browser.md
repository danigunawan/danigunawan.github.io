---
layout: post
title: install ssl berbayar di vps
modified: 2022-11-23T08:00:00+07:00
categories:
description: "install ssl berbayar di vps"
tags: [ssl]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-23T08:00:00+07:00
published: false
# permalink: "/encrypted.html"
---

mkdir -p ~/.config
docker run -d --cpus=1 --memory=2g --shm-size=2G --name code-server -p 2222:8080 \
  -v "$HOME/.config:/home/coder/.config" \
  -v "/home/coder:/home/coder/project" \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  -e "PASSWORD=your_password" \
  codercom/code-server:latest


  docker run -d --cpus=1 --memory=1g --shm-size=1G --name pt-pal2 -p 2222:8080 \
  -v "$HOME/.config:/home/coder/.config" \
  -v "/:/home/coder/project" \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  -e "PASSWORD=your_password" \
  codercom/code-server:latest


