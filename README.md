[[Buildroot for RK3399]

==Introduction to Buildroot==
{{RK3399 Buildroot Intro}}

==Download Images of Trial Version==
Visit [http://download.friendlyarm.com/nanopct4 Download Link]Download:<br />
{| class="wikitable"
|-
  | colspan=2 | Image Files
|-
  | rk3399-sd-buildroot-linux-4.4-arm64-YYYYMMDD.img.zip
  | OS image booting from SD card
|-
  | rk3399-eflasher-buildroot-YYYYMMDD.img.zip
  | Image used to flash to eMMC
|}
After extract the file you can use either dd or the win32image utility to flash the image to an SD card.
==User Name and Password==
User name: root<br />
Password: rockchip<br />
<br />
==Obtain Source Code==
===Install repo Utility===
Install the repo utility:
<syntaxhighlight lang="bash">
git clone https://github.com/friendlyarm/repo
cp repo/repo /usr/bin/
</syntaxhighlight>
===Download Source Code===
You can retrieve a project's source code in either of the following two ways. The first works better with Mainland Chinese users:
====1: Retrieve Repo Package from Cloud Storage====
Download link: [http://download.friendlyarm.com/{{#replace:{{#replace:{{BASEPAGENAME}}| |}}|/zh|}} Click to enter]<br />
File location: sources/linuxsdk-friendlyelec-YYYYMMDD.tar (YYYYMMDD stands for the data when the package is generated)<br />
After you get a tar package, untar it and run the following command to extract it:
<syntaxhighlight lang="bash">
tar xvf /path/to/netdisk/sources/linuxsdk-friendlyelec-YYYYMMDD.tar
cd linuxsdk-friendlyelec
repo sync -l
</syntaxhighlight>
If you want to get the latest official source code you can run the following commands:
<syntaxhighlight lang="bash">
cd linuxsdk-friendlyelec
repo sync
</syntaxhighlight>
====2: Retrive Repo Package from Github====
<syntaxhighlight lang="bash">
mkdir linuxsdk-friendlyelec
cd linuxsdk-friendlyelec
repo init -u https://github.com/friendlyarm/buildroot_manifests -b master -m rk3399_linux_release.xml --repo-url=https://github.com/rockchip-linux/repo
repo sync -c
</syntaxhighlight>
====Get Latest Version with Sync====
<syntaxhighlight lang="bash">
cd linuxsdk-friendlyelec
repo sync -c
</syntaxhighlight>
If your network connection is broken during sync you can run the following script to do it:
<syntaxhighlight lang="bash">
#! /bin/bash
repo sync -c
while [ $? -ne 0 ]; 
do  
    repo sync -c
done
</syntaxhighlight>

==Compile Source Code==
===Setup Compilation Environment===
Under Ubuntu on a host PC run the following command:
<syntaxhighlight lang="bash">
sudo apt-get install repo git-core gitk git-gui gcc-arm-linux-gnueabihf u-boot-tools device-tree-
compiler gcc-aarch64-linux-gnu mtools parted libudev-dev libusb-1.0-0-dev python-linaro-image-
tools linaro-image-tools autoconf autotools-dev libsigsegv2 m4 intltool libdrm-dev curl sed make
binutils build-essential gcc g++ bash patch gzip bzip2 perl tar cpio python unzip rsync file bc wget
libncurses5 libqt4-dev libglib2.0-dev libgtk2.0-dev libglade2-dev cvs git mercurial rsync openssh-
client subversion asciidoc w3m dblatex graphviz python-matplotlib libc6:i386 libssl-dev texinfo
liblz4-tool genext2fs lib32stdc++6
</syntaxhighlight>

===Auto Compilation===
<syntaxhighlight lang="bash">
./build.sh
</syntaxhighlight>
===Compile Partial Code===
====kernel====
<syntaxhighlight lang="bash">
./build.sh kernel
</syntaxhighlight>
====u-boot====
<syntaxhighlight lang="bash">
./build.sh uboot
</syntaxhighlight>
====rootfs====
<syntaxhighlight lang="bash">
./build.sh rootfs
</syntaxhighlight>
===Generate Image for SD Card===
<syntaxhighlight lang="bash">
sudo ./build.sh sd-img
</syntaxhighlight>
Flash an image to an SD card:
<syntaxhighlight lang="bash">
./friendlyelec/rk3399/sd-fuse_rk3399/fusing.sh /dev/sdX buildroot
</syntaxhighlight>
The "/dev/sdX" needs to be replaced with your actual SD card device name.
===Generate Image for EMMC(Eflasher)===
<syntaxhighlight lang="bash">
sudo ./build.sh emmc-img
</syntaxhighlight>

===Check Help Info===
<syntaxhighlight lang="bash">
# ./build.sh help
====USAGE: build.sh modules====
uboot              -build uboot
kernel             -build kernel
rootfs             -build default rootfs, currently build buildroot as default
buildroot          -build buildroot rootfs
ramboot            -build ramboot image
yocto              -build yocto rootfs, currently build ros as default
ros                -build ros rootfs
debian             -build debian rootfs
pcba               -build pcba
recovery           -build recovery
all                -build uboot, kernel, rootfs, recovery image
cleanall           -clean uboot, kernel, rootfs, recovery
firmware           -pack all the image we need to boot up system
updateimg          -pack update image
sd-img             -pack sd-card image, used to create bootable SD card
emmc-img           -pack sd-card image, used to install buildroot to emmc
save               -save images, patches, commands used to debug
default            -build all module
</syntaxhighlight>
Comments on popular parameters:<br />
uboot              -compile uboot only<br />
kernel             -compile kernel only<br />
rootfs             -compile buildroot only<br />
buildroot          -compile buildroot only<br />
sdimg              -generate an image which can be flashed to an SD card with the "dd" command and to eMMC with eFlasher<br />
<br />

==Customize Buildroot==
===Structure of Directories===
<syntaxhighlight lang="bash">
├── linuxsdk-friendlyelec
│   ├── app
│   ├── buildroot buildroot's root directory
│   ├── build.sh -> device/rockchip/common/build.sh script for auto-compilation
│   ├── device configuration files
│   ├── distro debian's root directory
│   ├── docs documents
│   ├── envsetup.sh -> buildroot/build/envsetup.sh
│   ├── external
│   ├── friendlyelec configuration files for FriendlyElec's RK3399 
│   ├── kernel kernel
│   ├── Makefile -> buildroot/build/Makefile
│   ├── mkfirmware.sh -> device/rockchip/common/mkfirmware.sh script to update rockdev 
│   ├── prebuilts
│   ├── rkbin 
│   ├── rkflash.sh -> device/rockchip/common/rkflash.sh flashing script
│   ├── rootfs directory of debian's root file system
│   ├── tools tools and utilities for flashing and packaging
│   └── u-boot u-boot
</syntaxhighlight>
====Update Buildroot Configurations====
* List Available Configurations
<syntaxhighlight lang="bash">
cd buildroot
make list-defconfigs
</syntaxhighlight>
Here is what you would get:<br />
rockchip_rk3399_defconfig           - Build for rockchip_rk3399<br />
* Update Configurations Using menuconfig
<syntaxhighlight lang="bash">
make rockchip_rk3399_defconfig
make menuconfig
make savedefconfig
diff .defconfig configs/rockchip_rk3399_defconfig 
cp .defconfig configs/rockchip_rk3399_defconfig
</syntaxhighlight>
* Recompile
<syntaxhighlight lang="bash">
cd ../
./build.sh rootfs
</syntaxhighlight>
===Customize File System===
Put your files in the friendlyelec/rk3399/fs-overlay-64 directory and recompile "rootfs"
===Update U-boot and Kernel===
You can do it by directly updating the files in the u-boot and kernel directories.
===Use Cross Compiler in SDK===
<syntaxhighlight lang="bash">
export PATH=$PWD/buildroot/output/rockchip_rk3399/host/bin/:$PATH
aarch64-buildroot-linux-gnu-g++ -v
</syntaxhighlight>
Version information:<br />
gcc version 6.4.0 (Buildroot 2018.02-rc3-g4f000a0797)
===Cross Compile Qt Program===
<syntaxhighlight lang="bash">
git clone https://github.com/friendlyarm/QtE-Demo.git
cd QtE-Demo
../buildroot/output/rockchip_rk3399/host/bin/qmake QtE-Demo.pro
make
</syntaxhighlight>
You can auto-run your Qt program on system boot. For example you want to auto-run a QtE-Demo program. Firstly you can copy the QtE-Demo to your board, open and edit the S50launcher file under the "/etc/init.d/" directory, replace "/usr/local/QLauncher/QLauncher &" with the full path of your QtE-Demo program.
==Q&A==
===Generate Image File for Flashing with USB Type-C===
After you run the "build.sh emmc-img" command a "buildroot" directory will be generated under the "friendlyelec/rk3399/sd-fuse_rk3399" directory. You can use the android_tools to load all the files under this "buildroot" directory.

==Update Log==
===May-16-2019===
* Released English version

