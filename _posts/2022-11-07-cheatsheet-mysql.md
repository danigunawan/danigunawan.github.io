---
layout: post
title: Kumpulan Cheatsheet mysql
description: "Kumpulan Cheatsheet mysql"
tags: [mysql, sql, cheatsheet, cheatsheet mysql]
image:
  background: triangular.png
---


## Cheatsheet MySQL

{% highlight sql %} 
Mengizinkan MySQL client untuk menghubungkan ke Remote Host

mysql -u root -p
Enter password:
mysql> use mysql
mysql> GRANT ALL ON *.* to root@'192.168.1.4' IDENTIFIED BY 'your-root-password';
mysql> FLUSH PRIVILEGES;

MySQL Database Dump

mysqldump -u user -p db-name > db-name.out

Delete MySQL Data dari table

Ada dua cara untuk menghapus semua data dalam tabel database MySQL.

TRUNCATE TABLE tablename;

Ini akan menghapus semua data dalam tabel dengan sangat cepat. Di MySQL tabel sebenarnya didrop dan dibuat ulang, karenanya kecepatan kueri. Jumlah baris yang dihapus untuk tabel MyISAM yang dikembalikan adalah nol/kosong; untuk INNODB ia mengembalikan nomor aktual yang dihapus.

DELETE FROM tablename;

Ini juga menghapus semua data dalam tabel, tetapi tidak secepat menggunakan metode "TRUNCATE TABLE". Di MySQL >= 4.0 jumlah baris yang dihapus dikembalikan; di MySQL 3.23 angka yang dikembalikan selalu nol.

Mengekspor Skema/Struktur DB (tanpa data) saja

mysqldump -u root -p --no-data dbname > schema.sql

Backup Multiple Database

mysqldump –u[user name] –p[password] [database name 1] [database name 2] .. > [dump file]

Backup ALL Database

shell> mysqldump –u[user name] –p[password] –all-databases > [dump file]

Backup Specific Table in a Database

shell> mysqldump --user [username] --password=[password] [database name] [table name] > /tmp/sugarcrm_accounts_contacts.sql

Restoring MySQL Database

shell> mysql --u [username] --password=[password] [database name] < [dump file]

Export Database in Zipped (.gz) format

mysqldump -hlocalhost -uUSERNAME -pPA$$W0RD DATABASE | gzip > /home/USERNAME/backups-mysql/BACKUP.gz

Optimize Single Database:

./mysqlcheck -o database_name

Optimize All Databases:

./mysqlcheck -o -A
 ./mysqlcheck -o --all-databases

Analyze Single Database:

./mysqlcheck -a database_name

Analyze All Databases:

./mysqlcheck -a -A
 ./mysqlcheck -a --all-databases

Repair Single Database:

./mysqlcheck -r database_name

Repair All Databases:

./mysqlcheck -r -A
 ./mysqlcheck -r --all-databases

Importing & Exprting a Table from Database

Export- mysqldump -p - -user=username dbname tableName > tableName.sq

Import- mysql -u username -p -D dbname < tableName.sql

MySQL Drop Table

mysql> use database 'yourdbname';

mysql> drop table 'yourtablename';

View MySQL users and privileges

mysql> select user,host from mysql.user;
mysql> show grants for 'root'@'%';
mysql> select * from mysql.user;
mysql> desc mysql.user;
select host, user, password from mysql.user;

Cara Membuat User MySQL Baru

CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';

Hal pertama yang harus dilakukan adalah memberi pengguna akses ke informasi yang mereka butuhkan.

GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';

Setelah Anda menyelesaikan izin yang ingin Anda siapkan untuk pengguna baru Anda, selalu pastikan untuk memuat ulang semua hak istimewa.

FLUSH PRIVILEGES;

Cara Memberikan Izin Pengguna MySQL
 
Berikut adalah daftar singkat dari pemberian izin umum MySQL lainnya yang dapat dinikmati oleh user MySQL.

ALL PRIVILEGES - seperti yang kita lihat sebelumnya, ini akan memungkinkan pengguna MySQL semua akses ke database yang ditunjuk (atau jika tidak ada database yang dipilih, di seluruh sistem)
CREATE - memungkinkan mereka untuk membuat tabel atau database baru
DROP - memungkinkan mereka untuk menghapus tabel atau database
DELETE - memungkinkan mereka untuk menghapus baris dari tabel
INSERT - memungkinkan mereka untuk memasukkan baris ke dalam tabel
SELECT - memungkinkan mereka untuk menggunakan perintah Select untuk membaca database
UPDATE - izinkan mereka memperbarui baris tabel
GRANT OPTION - memungkinkan mereka untuk memberikan atau menghapus hak istimewa pengguna lain

Untuk memberikan izin kepada pengguna tertentu, Anda dapat menggunakan kerangka kerja ini :

GRANT [type of permission] ON [database name].[table name] TO ‘[username]’@'localhost’;

Jika Anda ingin memberi mereka akses ke database atau tabel apa pun, pastikan untuk meletakkan tanda bintang (*) di tempat nama database atau nama tabel. Setiap kali Anda memperbarui atau mengubah izin, pastikan untuk menggunakan perintah Flush Privileges.

Jika Anda perlu mencabut izin, strukturnya hampir sama dengan pemberiannya:

REVOKE [type of permission] ON [database name].[table name] FROM ‘[username]’@‘localhost’;

Sama seperti Anda dapat menghapus database dengan DROP, Anda dapat menggunakan DROP untuk menghapus pengguna juga:

DROP USER ‘demo’@‘localhost’;

Jalankan OPTIMIZE TABLE untuk mendefrag tabel untuk kinerja yang lebih baik

mysqlcheck -u username -p --auto-repair --optimize --all-databases

Dapatkan ukuran Database MySQL dalam MB

SELECT table_schema AS "Database", ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Size (MB)" FROM information_schema.TABLES GROUP BY table_schema;

{% endhighlight %}