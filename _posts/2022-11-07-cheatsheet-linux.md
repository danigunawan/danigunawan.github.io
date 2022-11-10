---
layout: post
title: Kumpulan Cheatsheet Linux
description: "Kumpulan Cheatsheet Linux"
tags: [cheatsheet, cheatsheet linux]
image:
  background: triangular.png
---

## Kumpulan Cheatsheet Linux
{% highlight bash %} 
* Learning Nano

1. Find a text
Ctrl + W

2. Find and Replace
Ctrl + \

3. Find Help
Ctrl + G

4. Cut a Line and Paste
Ctrl + K and Ctrl + U

5. Copy some text and paste-
Copy beging Ctrl + ^ Copy end Ctrl + ^ For pasting Ctrol + U

* Find files older than 60 days
find * -mtime +60

* Delete files in backup folder which are older than 60 days
rm -f `find /backup/ -mtime +60`

* Search for a string inside files
grep -H -r “search me” /var/www

* Find files owned by apache user
find /var/www/ -user apache

* Find directories owned by apache user
find /var/www/ -user apache -type d

* Listing files in a directory
ls -lh or
ls -lh -a

* Copy an entire directory (files + subdirectories)
cp -R existingdir/ newdir/

* Zip up an entire directory
zip -r zipefilename foldername

* Count total number of files in a directory
ls -1 | wc -l
find . -type f | wc -l

* Get directory size
du -hs /var/www

* Get directory size by MB
du --max-depth=1 -B M |sort -rn
du -H /path --max-depth=1 -B M |sort -rn

* Get amount of free disk space available
df -h
df -H path
du -H path 

* Get Linux version details
uname -a
cat /proc/version

* Cannot delete oversized directories: /bin/rm: Argument list too long If you’re trying to delete files inside a directory and the following command is not working

/bin/rm -rf *
/bin/rm: Argument list too long. Try this instead: find . -type f -delete

* Use tar Command Through Network Over SSH Session
tar zcvf - /wwwdata | ssh root@192.168.1.201 "cat > /backup/wwwdata.tar.gz"

* How to know the OS Name (Use any of the following one)
cat /proc/version
cat /etc/os-release
lsb_release -a
hostnamectl

* Find the largest files in a directory From the Terminal, if you want to quickly find out what the largest files are in a directory, try this variation of the ls command:
ls -lShr (It will show sorted list)

* If you want the largest file in a directory of a certain type, simply specify the file type with a wildcard to show all files fitting that description:
ls -lShr *.rar

* Show disk usage by current directory and all subdirectories
du | less

* Delete 10000 of files using rm command
find . -name ‘*.mbox’ -print0 | xargs -0 rm

* Mount an ISO File Temporary
mount -t iso9660 -o loop /home/HsPS/disc/security.iso /mnt/cdrom

* Mount NTFS
yum install ntfs-3g
mkdir /mnt/win
mount -t ntfs-3g /dev/sdb1 /mnt/win

* Mount an ISO Permanently
vim /etc/fstab

* create a new line at the end and enter
/home/HsPS/disc/security.iso /mnt/cdrom ro,loop,_netdiv defaults 0 0

* IPVSADM commands
ipvsadm -L -n
ipvsadm -L -nc
ipvsadm -L -n --rate
ipvsadm -L -n --stats

* List Ethernet commands
lspci
lspci | less
lspci | grep -i eth

Chmod to change all the directories to 755 (-rwxr-xr-x):

find /opt/lampp/htdocs -type d -exec chmod 755 {} \;

Check OS Release Info

cat /etc/redhat-release
 ## Output ##
 CentOS release 6.6 (Final)

Following needs redhat-lsb package

 lsb_release -a
 ## Output ##
 LSB Version:    :core-4.0-amd64:core-4.0-ia32:core-4.0-noarch:graphics-4.0-amd64:graphics-4.0-ia32:graphics-4.0-noarch:printing-4.0-amd64:printing-4.0-ia32:printing-4.0-noarch
 Distributor ID: CentOS
 Description:    CentOS release 6.6 (Final)
 Release:        6.6
 Codename:       Final

Check if Machine supports Virtualization

 grep -E 'svm|vmx' /proc/cpuinfo

TAR Syntax

For compress

tar -cvf output.tar /dirname

For uncompress

tar -xvf /tmp/data.ta

Linux Standard Base (LSB)

To show the release number of installed distribution:

lsb_release -r

To show the distributor ID:

lsb_release -i

To show all of the above information:

lsb_release -a

Concatenated command:

lsb_release -ircd

To find Out the Kernel Version by using this command:

uname -mrs

Where:
Linux – Kernel name
3.2.0-24-generic – Kernel version
x86_64 – Kernel is 64-bit

Port Scanning

nmap -sT -O localhost

cat /etc/services | grep 834

netstat -anp | grep 834

lsof -i | grep 834

Add Default Route

route add default gw 192.168.1.254 eth0

Excluding directory when creating a .tar.gz file

tar -pczf MyBackup.tar.gz /home/user/public_html/ --exclude "/home/user/public_html/tmp"

Display files by date (descending)

ls -utlr

Repeat a command every x interval of time in terminal

watch -n x <your command>

TCPDump Capture and Save Packets in a File

tcpdump -w /tmp/0001.pcap -i eth0

or

tcpdump -w 0001.pcap -i eth0 port 80

TCPDump Capture Packets from source IP

tcpdump -i eth0 src 192.168.0.2

TCPDump Capture Packets from destination IP

tcpdump -i eth0 dst 50.116.66.139

TCPDump Capture IP address Packets

tcpdump -n -i eth0

TCPDump Capture Only N Number of Packets

tcpdump -c 5 -i eth0

ARP Scan (Find Connected Systems in the network)

arp-scan -I wlan0 192.168.1.0/24

Check Hypervisor

tephenm@pc:~$ apt-cache search virt-what
virt-what - detect if we are running in a virtual machine

sudo apt-get install virt-what

sudo virt-what

or

sudo dmidecode | egrep -i 'manufacturer|product|vendor'

or

sudo egrep -i 'virtual|vbox' /var/log/dmesg

How to Find a Specific String or Word in Files and Directories

The command below will list all files containing a line with the text “check_root”, by recursively and aggressively searching the ~/bin directory.

grep -Rw ~/bin/ -e 'check_root'

You should use the sudo command when searching certain directories or files that require root permissions (unless you are managing your system with the root account).

sudo grep -Rw / -e 'check_root'

To ignore case distinctions employ the -i option as shown:

grep -Riw ~/bin/ -e 'check_root'

If you want to know the exact line where the string of text exist, include the -n option.

grep -Rinw ~/bin/ -e 'check_root'

grep -Rnw --include=\*.sh ~/bin/ -e 'check_root'

If you want to know the exact line where the string of text exist, include the -n option.

grep -Rinw ~/bin/ -e 'check_root' -e 'netstat'

View Bash History and delete it permanently!

To view histroy just type-

history

Dump History to a file

history > history.txt

to delete the history /root/.bash_hitory file use the command instead!-

cat /dev/null > ~/.bash_history && history -c && exit

Check Linux OS

uname -a

lsb_release -a

lsb_release -a

cat /etc/issue.net

cat /etc/debian_version

What is my IP

curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'

Clear Cache in Linux

sync; echo 1 > /proc/sys/vm/drop_caches
sync; echo 2 > /proc/sys/vm/drop_caches
sync; echo 3 > /proc/sys/vm/drop_caches

Copy a folder keeping owners and permissions intact

cp -rp /home/my_home /media/backup/my_home

Change hostname in CentOS 7

hostnamectl set-hostname your-new-hostname

reboot

Finding free IPs from the range using nmap

sudo nmap -v -sn -n 192.168.1.0/24 -oG - | awk '/Status: Down/{print $2}'

Linux system resource command

lshw

lshw -short

lshw -html > lshw.html

Recursively look for files with a specific extension

find $directory -type f -name "*.in"

Monitor Copy command progress

$ watch -n 0.1 du -h /opt/dump.tar.gz
or
$ watch -n 0.1 ls -h /opt/dump.tar.gz

verify the speed of my NIC

$ sudo ethtool eth0 | grep Speed
Speed: 1000Mb/s

Remount /etc/fstab Without Reboot in Linux

# mount -a

View file as uncommented 

grep -v "^#" your_file | grep -v "^$" | less

Make scp copy hidden files

scp -rp src/. user@server:dest/


{% endhighlight %}