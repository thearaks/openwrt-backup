#!/bin/sh

#This script should be run as root, since it's accessing /etc.

#Set variables
CONFIG_FOLDER=/etc
BACKUP_FOLDER=/backup/backup
DELETION_THRESHOLD=+186
HOSTNAME=`uci get system.@system[0].hostname`
NOW=$(date +%Y%m%d_%H%M)

#Make backup directory if it doesn't exist
mkdir -p ${BACKUP_FOLDER}

#Remove all backups older than DELETION_THRESHOLD days
find ${BACKUP_FOLDER}/*packages*.txt -mtime ${DELETION_THRESHOLD} -type f -delete
find ${BACKUP_FOLDER}/*etc*.tar.gz -mtime ${DELETION_THRESHOLD} -type f -delete

#Backup installed package list
opkg list-installed | cut -f 1 -d ' ' > ${BACKUP_FOLDER}/${HOSTNAME}_packages_${NOW}.txt

#Backup /etc
tar -czf ${BACKUP_FOLDER}/${HOSTNAME}_etc_${NOW}.tar.gz ${CONFIG_FOLDER} >/dev/null 2>&1

exit
