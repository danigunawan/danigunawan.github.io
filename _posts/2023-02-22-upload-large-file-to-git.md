---
layout: post
title: Upload Large File To Git
modified: 2023-02-22T17:00:28+07:00
categories:
description: "Upload Large File To Git"
tags: [git, git cheatsheet]
image:
  background: triangular.png
comments: true
share: true
date: 2023-02-22T17:00:28+07:00
---

{% highlight bash %} 
1. Install and select LFS file 
git lfs install

# I am adding the deep learning model file
git lfs track "*.h5

2. Commit and push to the GitHub 
git lfs push --all origin main

git add .
git commit -am "add large file"
git push -u origin main

Solve large file upload issue

If already uploaded the file and remote: error: This model.h5 file is more than 100.00 MB in size exceeds the Git file size limit of 100.00 MB similar issue, It can be solved with those methods.

1. Reset Git
git reset HEAD~<HOWEVER MANY COMMITS YOU WERE BEHIND>
If you want to go before one commit: git reset HEAD~1
Tips: Check git log: git log

2. Check status and push 
git status
git push

{% endhighlight %}
