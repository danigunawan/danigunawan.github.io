---
layout: post
title: Pengantar Data Science Part 1
modified: 2022-11-22T11:00:00+07:00
categories:
description: "pengantar data science part 1"
tags: [data science, pengantar data science, apa itu data science]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-22T11:00:00+07:00
# permalink: "/encrypted.html"
---


Wajib bagi kamu yang ingin terjun ke dunia data science. !
Kita mulai dari data science, data science itu dipecah menjadi 3 bidang yang besar yaitu : 

- Analitik
- Modeling
- Testing

Namun seiring berkembangnya teknologi dan implementasi dibidang Data Science bermunculan bidang-bidang yang relevan dengan implementasi data science pada umumnya seperti :
- Operational 
- Researcher
- Security 

Mari kita lihat dari flow pekerjaannya bagaimana kita lihat aliran data nya bagaimana sebagai berikut : 

1. Analitik
dibidang analitik terdapat role-role yang bertugas dan bertanggung jawab atas data analitik sebagai berikut :
- Role Business Analyst

Bisnis analyst mencari kebutuhan bisnis itu apa (needsnya) setelah menemukan kebutuhan bisnisnya akan disampaikan ke data analyst requirement-requirement nya apa saja.

- Data Analyst 

Data Analyst bertugas mencari tahu data apa yang dibutuhkan untuk kebutuhan tadi yang sudah dicari oleh bisnis analyst. jika sudah terdapat data warehouse ditempat kebutuhan tersebut data analyst akan mencari sesuai kebutuhan tadi menentukan data mana yang dibutuhkan untuk kebutuhan yang disampaikan oleh bisnis analyst. data analyst juga concern terhadap reporting dan presentasi menyampaikan apa yang data analyst temukan, misalkan menemukan dari data yang kita miliki. jika data nya tidak dimiliki maka data analyst akan menyampaikan dan perlu mengumupulkan data tertentu yang dibutuhkan. Data analyst pun memanage datanya sehingga ada yang namanya roles yakni Data Architect.

- Data Architect

Data Architect bertugas membuat blueprint aliran data mulai dari yang RAW sampai disimpan ke Database/Warehouse. Blueprint ini secara teknisnya akan dikerjakan oleh Data Engineer sehingga lebih detail dikerjakan oleh Data Engineer yang biasa disebut yaitu Data Pipeline.

- Data Engineer 

Data Engineer bertugas membuat Blueprint aliran data atau data pipeline sehingga mudah diakses dan ditarik datanya oleh Data Analyst, Pipeline tersebut meliputi seperti Data Cleaning, Data Transformation atau yang biasa kita kenal ETL (Extract, Transform dan Load). Data Warehouse dipakai tidak hanya oleh Data Analyst akan tetapi ada tim-tim lain misalkan tim A, B dan C sehingga kita harus memanage juga bahwa tim A boleh mengakses data apa saja, tim B data apa saja maupun tim C dan itu akan dimanage oleh yang namanya Database Administrator

- Database Admin 

Database administrator bertugas dan fokus memberikan akses atau roles sebuah data, selain itu database admin akan fokus ke blueprint terutama ke bagian proteksi data / keamanan data (Data Security) jadi akses sebuah database perlu safety dan aman, database admin pun bertugas untuk membackup data 

Jadi pada bagian Analitik ini fokusnya lebih ke "APA" needsnya kebutuhan bisnis kita, apa informasi yang bisa kita dapatkan dari data kita jadi Analitik ini bentuk nya lebih ke reporting.

Ketika kita sudah mendapatkan insight next stepnya adalah selain reporting / insight kita ingin melakukan Prediction dan jika ingin membutuhkan Prediction kita membutuhkan yang namanya model matematik, model yang dimana bisa melakukan sebuah Prediksi sehingga setelah bidang analitik ini ada fase Modeling.

2. Modeling 
- Data Scientist 

Data analyst ini merupakan Data Analyst yang sudah memiliki pengalaman dan berkembang menjadi Data Scientist sehingga fokusnya jadi berbeda yakni dibidang permodelan, fokusnya melakukan Prediksi "In The Future" mau prediksi apa sesuai dengan kebutuhan bisnis, namun terkadang Role Data scientists ini datang beragam dari disiplin ilmu seperti statistika, matematika, teknik sampai dengan bisnis sehingga trend kedepan data scientists ini menjadi roles yang diminati karena begitu luas implementasinya.

- ML Engineer
- AI Engineer

3. Testing

4. Research
- ML Researcher 
- AI Researcher

5. Operational
- MLOps
- AIOps

6. Security 
- MLSecOps
- AISecOps