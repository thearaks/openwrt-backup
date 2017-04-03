# openwrt-backup
Ash script to backup OpenWrt config files.

### Requirements
In OpenWrt 15.05 **requires** that **find** is compiled with **-mtime option enabled**, so you need to compile a custom image.
You can enable -mtime option in menuconfig under:

`Base system > Busybox > Finding Utilities > Enable -mtime: modified time watching`

This option is enabled by default in OpenWrt trunk since Oct. 31, 2015; see https://lists.openwrt.org/pipermail/openwrt-devel/2015-October/036897.html.

### Usage
The generate_backups.ksh script backs up the list of installed packages and the /etc directory using tar. The script runs out of root's crontab once a month.

`0 2 5 * * /scripts/openwrt-backup/generate_backups.sh`


The *download_backups.ksh* script is run on your local machine and uses rsync over SSH to download the files from the server (assuming you have SSH keys setup).

To re-download the packages, restore the packages.txt file and run it through a loop.  
`cat packages.txt | while read PACKAGE; do opkg install $PACKAGE; done`
