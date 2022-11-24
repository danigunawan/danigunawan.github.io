---
layout: post
title: Belajar VirtualBox Headless dan PHPVirtualBox Ubuntu/Mint
modified: 2022-11-8T20:00:28+07:00
categories:
description: "Belajar VirtualBox Headless dan PHPVirtualBox Ubuntu/Mint"
tags: [virtualbox, phpvirtualbox, headless]
image:
  background: triangular.png
comments: true
share: true
date: 2022-11-8T17:00:28+07:00
---

## Apa Itu Virtualbox ?

<div style="text-align: justify">
VirtuaBox adalah tools / perangkat virtualisasi untuk menginstall sistem operasi didalamnya biasanya virtualbox digunakan sebagai alat / tools pengujian, membantu lingkungan development.
</div>

## Apa Itu Virtualbox Headless Vs GUI ?

<div style="text-align: justify">
VirtuaBox Headless adalah virtualbox yang menjalankan virtual machine secara background tanpa adanya interkasi GUI sedangkan GUI sebaliknya ada interaksi GUI.
</div>

## Apa Itu PHPVirtualBox ?

<div style="text-align: justify">
PHPVirtuaBox adalah tools / perangkat yang mendukung virtualbox client web dalam manajemen virtualisasi.
</div>

  
Prasarat yang dibutuhkan untuk menjalankan VirtualBox dan PHPVirtualBox adalah sebagai berikut.

OS & Tools (Prerequisite): 

* VirtualBox 7.0.2
* PHPVirtualBox (Hanya Mendukung VirtualBox 6.1.0) 
* OS Ubuntu 18.04 Bionic

## Install VirtualBox 7.0.2 + PHPVirtualBox di Ubuntu 18.04 Bionic
{% highlight bash %} 
# Membuat User Deploy
sudo -s 
sudo adduser deploy
sudo usermod -aG sudo deploy
passwd deploy 
su deploy

# Installing VirtualBox
sudo apt update
sudo apt -y install build-essential dkms unzip wget libarchive-tools curl gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates
echo "deb [arch=$(dpkg --print-architecture)] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee -a /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt update
sudo apt -y install virtualbox-7.0
sudo systemctl status vboxdrv

# Installing VirtualBox Extension Pack
VB_VERSION=$(dpkg-query --showformat='${Version}' --show virtualbox-7.0 | awk -F'-' '{print $1}')
wget https://download.virtualbox.org/virtualbox/$VB_VERSION/Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack

sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$VB_VERSION.vbox-extpack

vboxmanage list extpacks

# membuat user vboxadmin
sudo useradd vboxadmin

# set vboxadmin password
sudo passwd vboxadmin # password

# tambahkan vboxadmin kedalam group vboxuser
sudo usermod -aG vboxusers vboxadmin

# membuat direktori vboxadmin di path home
sudo mkdir /home/vboxadmin -p

# membuat pengaturan akses owner path vboxadmin sebagai owner di home direktori
sudo chown -R vboxadmin /home/vboxadmin

# edit dan tambahkan konfigurasi default virtualbox 
sudo nano /etc/default/virtualbox

VBOXWEB_USER=vboxadmin
#VBOXWEB_PASSWD=[the password you set when you created the vbox user]
VBOXWEB_HOST=192.168.1.9
#VBOXWEB_PORT=18083 # default 18083
#VBOXWEB_TIMEOUT=
#VBOXWEB_CHECK_INTERVAL=
#VBOXWEB_THREADS=
#VBOXWEB_KEEPALIVE=
VBOXWEB_LOGFILE=/home/vboxadmin/.config/VirtualBox/vboxweb-service.log
#INSTALL_DIR=

# lalu save

# membuat vboxweb.sh
sudo nano /home/vboxadmin/vboxweb.sh

#!/bin/bash
/usr/bin/vboxwebsrv -H 192.168.1.9 > /dev/null 2>&1

# ubah vboxweb.sh menjadi agar bisa di eksekusi
sudo chmod +x /home/vboxadmin/vboxweb.sh

# membuat servis phpvirtualbox.service
sudo nano /etc/systemd/system/phpvirtualbox.service

# dan simpan seperti konfigurasi dibawah ini
[Unit]
Description=VirtualBox Web Service
After=network.target
[Service]
Type=simple
RemainAfterExit=yes
User=vboxadmin
Group=vboxusers
WorkingDirectory=/home/vboxadmin
ExecStart=/home/vboxadmin/vboxweb.sh
Restart=on-failure
[Install]
WantedBy=default.target

# Aktifkan phpvirtualbox.service
sudo systemctl enable phpvirtualbox.service

# Jalankan phpvirtualbox.service
 sudo systemctl start phpvirtualbox.service

# Install Skrip PHPVirtualBox (Via Docker)
Struktur Code :
- config.php (berisikan konfigurasi phpvirtualbox)
- Dockerfile (file konfigurasi builder images docker)
- nginx.conf (konfigrasi web phpvirtualbox dan reverse proxy nya)
- servers-from-env.php (konfigurasi untuk environment autoload untuk phpvirtualbox)
- Makefile (untuk shortcut pengembangan)

# Langkah Pertama Build Images 
docker build --no-cache -f Dockerfile -t phpvirtualbox6x .

# Jalankan PHPVirtualBox dengan Docker yang sudah dibuild
sudo docker run --name vbox_http --restart=always -p 8149:80 \
        -e SRV1_HOSTPORT=172.17.0.1:18083 -e SRV1_NAME=ServerVBOX -e SRV1_USER=vboxadmin -e SRV1_PW='password' \
        -d phpvirtualbox6x

* -p 8149:80 : port yang diekspose dari docker (80) dari container kita expose ke luar dengan menggunakan port alias 8149 (mirip seperti metode forwarding pada port/NAT)
* --name vbox_http : argument docker untuk menset nama container 
* --restart=always : container dijalankan dan diset default dengan konfigurasi restart always jadi jika servis mati bisa hidup lagi
* -d : docker dijalankan secara background
* phpvirtualbox6x : nama images phpvirtualbox yang kita build tadi
* ENV SRV1_HOSTPORT : Merupakan Host Server VirtualBox melalui servis vboxweb yang berjalan di port 18083 (yang membantu untuk dikonfigurasi melalui phpvirtualbox) disini kita bisa set dengan any host (0.0.0.0) atau pakai IP GW Docker 172.17.0.1
* ENV SRV1_NAME: Nama server Vbox kita set ServerVBOX
* ENV SRV1_USER: username vboxweb yang digunakan phpvirtualbox
* ENV SRV1_PW: Passowrd vboxweb yang digunakan phpvirtualbox

# Login ke phpvirtualbox
http://192.168.1.9:8149/
dengan username dan password default : admin/admin 

# Ganti Password Default 
di menu file - > change password 

{% endhighlight %}

# Running VirtualBox Headless Via CLI
Start VirtualBox VM in Headless Mode

# List virtual machines
VBoxManage list vms
"MyVM" {e4b0c92c-4301-4a7d-8af8-fe02fed00451}

# Start VM in headless mode
VBoxManage startvm MyVM --type headless

# Power off VM
VBoxManage controlvm MyVM poweroff
VBoxManage controlvm win_7_ultimate poweroff

## Troubleshooting 

1. This version of phpVirtualBox (6.1-0) is incompatible with VirtualBox 7.0.2. You probably need to download the latest phpVirtualBox 7.0-x. See the Versioning section below the file list in the link for more information

Notice diatas dikarenakan phpvirtualbox 6.1 tidak mendukung dengan virtualbox 7.0.2 karena phpvirtualbox pengembangannya stuck alias kurang jadi solusinya pakai versi develop.

Untuk Solusi : 
Pakai PHPVirtualBox dengan branch develop / master saya biasanya pakai develop karena saat direview cukup stable dan Downgrade VirtualBox dengan Versi 6.1.0 karena phpvirtualbox hanya mendukung VirtualBox sampai dengan versi 6.1.0

Clone Repository : 
https://github.com/phpvirtualbox/phpvirtualbox.git -b develop

karena lambat pengembangannya phpvirtualbox belum lagi karena segudang sekuritas dan bug nya jadi sebenarnya virtualbox ini punya gandengan yang lebih hebat secara stack management virtualisasinya ya kita kenal dengan Vagrant by HashiCorp, semua environment bisa kita racik sesuai kebutuhan.

2. How VM Machine Enable Autostart when booting?
Auto Start Virtual Box VM's on Linux

Create Config Files
/etc/default/virtualbox
sudo nano /etc/default/virtualbox then add:

VBOXAUTOSTART_DB=/etc/vbox
VBOXAUTOSTART_CONFIG=/etc/vbox/autostart.cfg
/etc/vbox/autostart.cfg
sudo nano /etc/vbox/autostart.cfg then add:

default_policy = deny
kevin = {
allow = true
}
Change Permissions
sudo chgrp vboxusers /etc/vbox sudo chmod 1775 /etc/vbox

Then, for each allowed username: sudo usermod -aG vboxusers USERNAME

:~$ ls -l /etc/vbox
total 8
-rw------- 1 USERNAME USERNAME   1 Dec 14 01:37 USERNAME.start
-rw-r--r-- 1 root     root     179 Dec 14 01:31 vbox.cfg

Note: Log out and in for it to apply.
VBoxManage: error: Adding machine ‘Ubuntu-VM’ to the autostart database failed with VERR_ACCESS_DENIED If you this error message, manually create <userid>.start file under /etc/vbox

Choose VMs to automatically start
Run the on-time command VBoxManage setproperty autostartdbpath /etc/vbox.

Add VM’s!
VBoxManage list vms
VBoxManage modifyvm <uuid|vmname> --autostart-enabled <on|off>
Restart VirtualBox autostart service
sudo service vboxautostart-service restart or reboot the machine.

Altenrative 1 : 

This is working ok with Ubuntu server 12.04 and VirtualBox 4.2.20.

1) Create the startup script file
in /etc/init.d - sudo nano /etc/init.d/StartVM.

#! /bin/sh
# /etc/init.d/StartVM
#
#Edit these variables!
VMUSER=username
case "$1" in
  start)
    echo "Starting VirtualBox VM SMARTHOST ..."
    sudo -u $VMUSER VBoxManage startvm SMARTHOST --type headless
    echo "Starting VirtualBox VM wxp-acceso ..."
    sudo -u $VMUSER VBoxManage startvm wxp-acceso --type headless
    echo "Starting VirtualBox VM wmmaq_edi ..."
    sudo -u $VMUSER VBoxManage startvm vmmaq_edi --type headless
    ;;
  stop)
    echo "Saving state of Virtualbox VM SMARTHOST ..."
    sudo -u $VMUSER VBoxManage controlvm SMARTHOST savestate
    echo "Saving state of Virtualbox VM wxp-acceso ..."
    sudo -u $VMUSER VBoxManage controlvm wxp-acceso savestate
    echo "Saving state of Virtualbox VM vmmaq_edi ..."
    sudo -u $VMUSER VBoxManage controlvm vmmaq_edi savestate
    ;;
  *)
    echo "Usage: /etc/init.d/StartVM {start|stop}"
    exit 1
    ;;
esac

exit 0
And

2) Give the script executable permission
sudo chmod +x /etc/init.d/StartVM

ls -l /etc/init.d/StartVM
-rwxr-xr-x 1 YOUR_USERNAME YOUR_USERNAME 468 Nov 23 12:39 /etc/init.d/StartVM

and

3) Tell script to run at startup.
sudo update-rc.d StartVM defaults 99 01

sudo update-rc.d StartVBox defaults

Notes : 
Warning vboxdrv kernel module is not loaded
add line on /etc/init.d/StartVM : 
sudo modprobe vboxdrv

start)
  sudo modprobe vboxdrv
  echo "Starting VirtualBox VM SMARTHOST ..."
  sudo -u $VMUSER VBoxManage startvm SMARTHOST --type headless


Alternative 2 : 

1) Create the startup script file
in /etc/init.d - sudo nano /etc/init.d/StartVM.

Copy Paste the following in the file and replace "My VM Name" for your vm name:

#! /bin/sh
# /etc/init.d/StartVM
#

#Edit these variables!
VMUSER=spode
VMNAME="My VM Name"

case "$1" in
  start)
    echo "Starting VirtualBox VM..."
    sudo -H -b -u $VMUSER /usr/bin/VBoxVRDP -s "$VMNAME"
    ;;
  stop)
    echo "Saving state of Virtualbox VM..."
    sudo -H -u  $VMUSER /usr/bin/VBoxManage controlvm "$VMNAME" savestate
    ;;
  *)
    echo "Usage: /etc/init.d/StartVM {start|stop}"
    exit 1
    ;;
esac

exit 0
2) Give the script executable permission
with sudo chmod +x /etc/init.d/StartVM.

3) Tell script to run at startup.
tell the script be the first to shutdown and the last to startup.

sudo update-rc.d StartVM defaults 99 01

Refferences : 
- https://mcgilldevtech.com/2020/04/auto-start-virtual-box-vms-on-linux/
- https://forums.virtualbox.org/viewtopic.php?f=7&t=90767
- https://askubuntu.com/questions/57220/start-vboxheadless-vm-at-startup
- https://gigihfordanama.wordpress.com/2012/01/11/how-to-make-virtual-box-image-auto-start-on-ubuntu-without-gui/

3. Warning vboxdrv kernel module is not loaded
sudo modprobe vboxdrv

Refferences : 
https://stackoverflow.com/questions/23740932/warning-vboxdrv-kernel-module-is-not-loaded

4. Virtual Box Settings to automatically run VMs on boot
I had this problem too. The issue is that the autostart service script is trying to include /etc/vbox/vbox.cfg just like it does with /etc/default/virtualbox. You need to use a different filename for the autostart config.

Rename /etc/vbox/vbox.cfg -> /etc/vbox/autostart.cfg

Update VBOXAUTOSTART_CONFIG in /etc/default/virtualbox:

VBOXAUTOSTART_CONFIG=/etc/vbox/autostart.cfg

Refferences : https://askubuntu.com/questions/1101021/virtual-box-settings-to-automatically-run-vms-on-

Alternative 3 (easy use and work) : 

Autostart Virtualbox VMs
So... certainly things evolve quickly and others lack behind. We've got systemd since 15.10 or so and it was the prominent change in 16.04. We actually made the switch for Snap! Websites and that help tremendously as it is very reliable since then (older versions were really bad in comparison.)

At first, I found a Stackoverflow answer describing the old way and it did not work which is why I decided to switch to systemd. I found this page about it and it's already pretty good! Just a couple of things I had to tweak on my system to make it all work properly.

Click to learn more on how to manage an environment of VirtualBox computers
Click to learn it all
(available on Amazon)
Deleting the Old Way
Just to make sure it works properly, delete the files from the old environment if you created them. If you did edits to some of them, you probably want to undo those edits.

This is to make sure that the old way doesn't suddenly kick in and mess up your systemd setup.

$ rm -rf /etc/vbox
On my end, I edited the /etc/default/virtualbox file to add these two variables:

VBOXAUTOSTART_DB=/etc/vbox
VBOXAUTOSTART_CONFIG=/etc/vbox/autostart.cfg
So I went ahead and deleted those two lines.

However, I also changed the following and that I kept:

#SHUTDOWN=poweroff
SHUTDOWN=acpibutton
I prefer to have a good APCI shutdown and a plain power off. If it takes too long to shutdown, we'll anyway get a power off (a.k.a. a kill).

If you did anything else to try to make the old way work, please make sure to revert that too. You're on your own on that side of things...

Create Service File
Now you are ready to create a service file.

In mine, I have pretty much the same thing as the one from the page I referenced above, except for the vboxdrv.service. I'm not too sure where that came from, but under Ubuntu 18.04, there is no such thing. Though I remove that one reference.

The script includes two names you need to change:

vm1 — enter the name of your Virtualbox machine (this one appears three times)
alexis — unless you are also an alexis and your account is name like that, change that name

Then save the file under /etc/systemd/system/.

For example, if you use gvim to edit your files:

$ sudo gvim /etc/systemd/system/vm1.service
Then copy/paste the following and do the edits as expected:

[Unit]
Description=vm1
After=network.target virtualbox.service vboxdrv.service
Before=runlevel2.target shutdown.target
 
[Service]
User=alexis
Group=vboxusers
Type=forking
Restart=no
TimeoutSec=5min
IgnoreSIGPIPE=no
KillMode=process
GuessMainPID=no
RemainAfterExit=yes
 
ExecStart=/usr/bin/VBoxManage startvm vm1 --type headless
ExecStop=/usr/bin/VBoxManage controlvm vm1 acpipowerbutton
 
[Install]
WantedBy=multi-user.target
Note: the vboxdrv.service comes from a comment (see below) and should help even further (i.e. I have had problems with my services starting once in a while, most of the time, I still had to restart them by hand—I'll have to confirm once I reboot that it works every time).

Once the file is ready, you need to tell systemd to reload everything including that new file. It may do so automatically, but just in case here is the command you need:

sudo systemctl daemon-reload
Now you are ready to use this service.

Note: To see a list of services you have running on your system, the cleanest way is to use the following command:

sudo systemctl
It automatically sends its output to less so you don't have to pipe manually. At the bottom of the list comes a brief explaination of what the columns stand for. Especially, if a column says "failed", then the service doesn't work as expected.

Enable/Start/Stop Service
Now that we created a service file, we want to enable and start it. This supposes that your VM is ready to be started as if you were rebooting your machine.

Note that in the script above, there is nothing to say that one service should be started before and/or after another. It's doable but you should ask yourself whether it makes sense that the computers should be started in a very specific order. i.e. if something fails on computer B when A isn't running, it should keep trying until it works...

First, you can test that systemd recognize your file with:

$ systemctl status vm1
The status command is also useful to check whether a service is running or not.

Now you can start the VM.

$ sudo systemctl start vm1
It should return on the very next line unless something goes wrong.

If you have the Virtualbox UI open, you should see that it gets started there. The icon changes with what appears on the screen as normal. However, because we use the headless feature, you don't see the actual GUI part. You can show that window at any time while the machine is running by selecting the "→ Show" menu (it's found in the Machine menu or when you right-click on the VM).

Finally, to make the VM run automatically on a reboot, you need to enable it. This is done using the enable command like so:

$ sudo systemctl enable vm1
You can verify the current status at any time. Note that the enable state shows on its own. There are two entries in the output. Both should be enabled. Here is an example of the output. I highlighted the enabled you are looking for in red:

$ systemctl status vm1
● virtualbox_finball2.service - finball2
   Loaded: loaded (/etc/systemd/system/vm1.service; enabled; vendor preset: enabled)
   Active: active (exited) since Sat 2019-11-23 20:13:36 PST; 34s ago
    Tasks: 0 (limit: 9830)
   CGroup: /system.slice/vm1.service

Nov 23 20:13:35 monster systemd[1]: Starting vm1...
Nov 23 20:13:36 monster VBoxManage[12050]: Waiting for VM "vm1" to power on...
Nov 23 20:13:36 monster VBoxManage[12050]: VM "vm1" has been successfully started.
Nov 23 20:13:36 monster systemd[1]: Started vm1.
The last few lines are logs (called journals in systemd) showing what happened. It should say that it started your Virtualbox system.

You can later disable the service like so:

$ sudo systemctl disable vm1
which will prevent it from auto-restarting on a reboot. Note that you can still start a VM marked as being disabled.

Renaming a VM
I use rather long names for my VM that include:

The name of what I'm using the VM for
The OS name (Ubuntu, Fedora, FreeBSD, SunOS, MacOS, etc.)
The hostname of the computer running the VM (because when you run VMs on 3 or 4 different computers, it's not easy to know what's what otherwise)
The processor (i86x or amd64)
The sub-name of the computer (i.e. I create clusters that get one VM name + one sub-name such as front end, database, backend...)
I think such long names are great in the Virtualbox interface, but to type in your service file, it may cause problems (between dashes, spaces, parenthesis... and just the fact that such long names are hard to replicate without a few mistakes into them...)

So on my end, I had to rename the VMs. The cool thing, though, is that we now have grouping capabilities. So I can still keep my crazy naming convention for the group, and name each computer in the group something really simple (i.e. <cluster_name>_<sub-name> — for example wordpress_frontend and wordpress_database).

Where is My VM's Window?
The script is going to start the VM headless. This is actually important if you were to run the VM on a server without X-Windows. (Yes! It's doable, I'm just not too sure how you do the installation all by hand. It must be somewhat painful!)

Your VMs are going to start alongside the X-Windows environment and because of that, the X-Windows system may not be ready to open a window in the first place. So instead we start VMs headless.

When you are in the Virtualbox GUI, you see the VMs that are running. They have a green arrow. Right-click on those and select "→ Show" to open the window. Now you have full access to the VM's console. To hide the window again, you can of course minimize. However, if you want to actually close the X-Windows but leave the VM running, use the "Detach GUI" option found under the "Machine" menu.

In older versions (before 5.x), detaching the GUI was done in various ways:

Machine » Detach GUI
View » Close VM
Close VM (as a button)
Various Errors
The virtual machine has terminated unexpectedly during startup with exit code 0 (0x0).
Looking into that one, I could not really see why one of my virtual machine wouldn't start, especially with an exit code of 0... First I checked that the machine still existed as expected (right location, etc.) It was there.

So next I searched the Internet and found a page which I won't even link here, it was totally useless except for one small detail: one of the message was one person asking the other what they saw in their log file. Yes. Why wouldn't I look at that for once.

Here are the last few messages:

00:00:01.005004 GIM: KVM: Resetting MSRs
00:00:01.186998 VMSetError: /build/virtualbox-p8NxA3/virtualbox-5.2.34-dfsg/src/VBox/VMM/VMMR3/VM.cpp(326) int VMR3Create(uint32_t, PCVMM2USERMETHODS, PFNVMATERROR, void*, PFNCFGMCONSTRUCTOR, void*, VM**, UVM**); rc=VERR_VMM_R0_VERSION_MISMATCH
00:00:01.187018 VMSetError: The VMMR0.r0 module version does not match VBoxVMM.dll/so/dylib. If you just upgraded VirtualBox, please terminate all VMs and make sure that neither VBoxNetDHCP nor VBoxNetNAT is running. Then try again. If this error persists, try re-installing VirtualBox.
00:00:01.188756 ERROR [COM]: aRC=NS_ERROR_FAILURE (0x80004005) aIID={872da645-4a9b-1727-bee2-5585105b9eed} aComponent={ConsoleWrap} aText={The VMMR0.r0 module version does not match VBoxVMM.dll/so/dylib. If you just upgraded VirtualBox, please terminate all VMs and make sure that neither VBoxNetDHCP nor VBoxNetNAT is running. Then try again. If this error persists, try re-installing VirtualBox. (VERR_VMM_R0_VERSION_MISMATCH)}, preserve=false aResultDetail=0
00:00:01.189069 Console: Machine state changed to 'PoweredOff'
00:00:01.194933 Power up failed (vrc=VERR_VMM_R0_VERSION_MISMATCH, rc=NS_ERROR_FAILURE (0X80004005))
00:00:01.695786 GUI: UIMachineViewNormal::resendSizeHint: Restoring guest size-hint for screen 0 to 800x600
00:00:01.695873 ERROR [COM]: aRC=E_ACCESSDENIED (0x80070005) aIID={76eed314-3c72-4bbb-95cf-5eb4947a4041} aComponent={DisplayWrap} aText={The console is not powered up}, preserve=false aResultDetail=0
00:00:01.695961 GUI: Aborting startup due to power up progress issue detected...
And interestingly enough, they give you the exact answer of what to do next (3rd line in the logs above):

Sstop all your VMs;
Quit VirtualBox;
Make sure all the VM services are down (reboot if you want to make 100% sure); and
Restart VirtualBox.
Now it should work and it did for me.

The Old Way
At first, I tried the old way, mainly because there are a large number of posts in link with that one. But I just could not find the Virtualbox autostart script anywhere. I tried that once and nothing happened so I would imagine that it's missing (was removed) in new versions (Ubuntu 18.04 at least).

These are a few points I wanted to make regarding that method.

I go the following error when trying to install a Virtualbox in auto-start mode and trying to fix the problem took me a little while...

VBoxManage: error: Adding machine 'my-virtual-box' to the autostart database failed with VERR_ACCESS_DENIED
VBoxManage: error: Details: code NS_ERROR_UNEXPECTED (0x8000ffff), component SessionMachine, interface IMachine, callee nsISupports
VBoxManage: error: Context: "COMSETTER(AutostartEnabled)(ValueUnion.f)" at line 3035 of file VBoxManageModifyVM.cpp
The fact is that once you added yourselves to the vboxusers group, you need to log out and back in properly or even just forget about that group for a moment and use your primary group instead.

In other words, the docs I've found such as this one:

https://askubuntu.com/questions/404665/how-to-start-virtual-box-machines-automatically-when-booting

tell you to use vboxusers but you could also do that:

chgrp <my-primary-group> /etc/vbox
(Note: in most cases, your primary group name is your username)

and the chmod is not even necessary. Of course, that one won't help much if you want many users to be able to use the autostart feature. The idea is just to have a way to do your setup before you log out and/or test with a full restart of your computer (in my case, I have a monster with 512Gb of RAM, two processors with a total of 64 threads, it takes forever to reboot so I prefer to avoid it if I can.)

I'll try again and see whether it works if I restart the computer and I have the correct group in there...

However, I just rebooted and it did not work, there is still something fishy about it under 18.04, I just can't see the vbox service. I can see the Virtualbox kernel module, just no the service. I probably need to install something else...

Add new comment
Re: Autostart Virtualbox VMs in Ubuntu 18.04
Submitted by Anonymous (not verified) on Thu, 10/07/2021 - 18:33.
I'm running mint linux.

Noticed I was getting an error:

Oct 07 20:52:38 ShedPC VBoxManage[4984]: WARNING: The vboxdrv kernel module is not loaded. Either there is no module
Oct 07 20:52:38 ShedPC VBoxManage[4984]:          available for the current kernel (5.4.0-88-generic) or it failed >
Oct 07 20:52:38 ShedPC VBoxManage[4984]:          load. Please recompile the kernel module and install it by
Oct 07 20:52:38 ShedPC VBoxManage[4984]:            sudo /sbin/vboxconfig
Oct 07 20:52:38 ShedPC VBoxManage[4984]:          You will not be able to start VMs until this problem is fixed.
And then later on down the log, vboxdrv would load

Had to add the following lines to my config:

[Unit]
Description=FlexRadio
After=network.target virtualbox.service vboxdrv.service
Requires=virtualbox.service vboxdrv.service
Before=runlevel2.target shutdown.target
Don't know if I actually needed the Requires line, but seemed like a thing to do...

Many thanks for the webpage entry. It was of great help, easy to follow and well written.

reply
Re: Autostart Virtualbox VMs in Ubuntu 18.04
Submitted by Alexis Wilke on Thu, 01/02/2020 - 20:29.
I'm glad that my post helped you find out how to make it work on your machine.

On my end, if I run:

locate virtualbox.service
nothing is output. So I'm sure I do not have such a file and of course I can't wait on it being up/run if I want my boxes to start automatically. That being said, for me it works without that additional name.

That being said, there's a virtualbox script under /etc/init.d and it may be that your script will wait for that one to have run. That script makes sure that all the drivers are loaded before trying to start virtual boxes that are marked for auto-headless startup. But that did not work for me.

Update: The fact is that now I see the virtualbox.service file! I'm not too sure how/what changed, maybe I had to reboot or something. The fact is the last time I rebooted, my VMs did not start and since then I see that the virtualbox.service exists so I can depend on it. I updated my post accordingly.

reply
Re: Autostart Virtualbox VMs in Ubuntu 18.04
Submitted by Anonymous (not verified) on Thu, 01/02/2020 - 07:27.
Hi there, I followed your instructions, but found that adding network.target on the After line in /etc/systemd/system/vm1.service as you have suggested here was insufficient.

I found that without also adding an additional virtualbox.service entry on the After line my VMs were unable to find character device /dev/vboxdrv at boot and would fail to start.

As you have rightly point out in your article vboxdrv.service does not appear to exist on Ubuntu 18.04. However please be aware that Ubuntu DOES have the similarly named virtualbox.service available instead and we must wait for this to launch before loading any VMs.

In conclusion, in my own /etc/systemd/system/vm1.service file I have the following two lines which seems to work fine for me in Ubuntu 18.04:

After=network.target virtualbox.service
Before=runlevel2.target shutdown.target
reply


Refferences : 
https://linux.m2osw.com/autostart-virtualbox-vms

5. VBoxManage startvm win_7_ultimate --type headless
WARNING: The vboxdrv kernel module is not loaded. Either there is no module available for the current kernel (5.4.0-132-generic) or it failed to load. Please recompile the kernel module and install it by

Solution : 
sudo /sbin/vboxconfig

6. Service VBOX Backup

Refferences : 

- https://superuser.com/questions/789653/init-d-control-script-for-virtualbox-vm

- https://superuser.com/questions/470918/start-virtualbox-headless-vm-on-boot

7. Headless Firefox in VBOX
https://axiomq.com/blog/headless-firefox-in-ubuntu-on-virtualbox-for-cucumber-testing/