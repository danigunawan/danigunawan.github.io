---
layout: post
title: Belajar Git - Part 1
modified: 2022-11-7T20:00:28+07:00
categories:
description: "Belajar Git - Part 1"
tags: [git]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-7T17:00:28+07:00
---

1. Penggunaan git

{% highlight bash %} 
Get SSH Key
to get ssh key in your computer, and put in your github or gitlab ssh key setting.
cat ~/.ssh/id_rsa.pub

if there is not exist you must generate ssh key in next section
Generate RSA Key

Just One time for first instalation of git scm,

ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

Set config global

Just One time for first instalation of git scm,

git config --global user.name "John Doe"
git config --global user.email johndoe@example.com

Enabling SSH connections over HTTPS

nano ~/.ssh/config

Host github.com
  Hostname ssh.github.com
  Port 443
  User git

Host gitlab.com
  Hostname altssh.gitlab.com
  User git
  Port 443

Forking repository and keep update from source repo

Please click fork from web interface, after that clone your repo in your desktop. Select SSH in clone tab.

git clone git@github.com:youruserrepo/your_repos.git

git bash into your repo folder, just one time add upstream from source of fork repo. Use HTTPS in clone tab from source repo.

git remote add upstream https://github.com/danigunawan/your_repos.git

before pull request and working in your repo, always do

git fetch upstream
git checkout main
git merge upstream/main

After that you may pull request.

{% endhighlight %}