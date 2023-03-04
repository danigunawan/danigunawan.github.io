---
layout: post
title: Login SSH Dengan Key PEM Tanpa Password
modified: 2023-02-22T17:00:28+07:00
categories:
description: "Login SSH Dengan Key PEM Tanpa Password"
tags: [ssh, ssh-keygen]
image:
  background: triangular.png
comments: true
share: true
date: 2023-02-22T17:00:28+07:00
---

{% highlight bash %} 

1. Login Di server Katakan Ubuntu server A sebagai user root/user lain (misalkan ubuntu)
sudo su

2. Generate file PEM RSA
ssh-keygen -p -m PEM -f ~/.ssh/id_rsa

3. Buka file private key RSA dan copy di local komputer/server yang lain
cat ~/.ssh/id_rsa > mykey.pem # copykan mykey.pem ke laptop kamu/server lain yang ingin mengakses Ubuntu server A

4. Disable Password Authentication (Optional Jika ingin disable ssh password)

5. Login SSH Ke Ubuntu server A dengan Key PEM dari local laptop/server lain
sudo chmod 600 mykey.pem
ssh -i mykey.pem ubuntu@IP_ADDRESS -p 22 

{% endhighlight %}
