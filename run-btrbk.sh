#!/bin/bash

# Runs btrbk and logs success/failure timestamp.

# REQUIRES:
# - btrfsroot to be mounted. This is done in btrbk.service using mnt-btrbk.mount.
# rsync-backup to be on program path.

LOG_FILE=/var/log/btrbk.log

TIME_START=$(date "+%s")

BOOT_BACKUP_DIR=/boot-backup

mkdir -p $BOOT_BACKUP_DIR

# Run rsync on /boot directory, before snapshots.
# Backing up to root means that the correct /boot version will be tied to each root snapshot.
BOOT_BACKUP_DATETIME=$(/home/ava/Data/Scripts/bin/rsync-backup /boot $BOOT_BACKUP_DIR)

#If not empty
BOOT_CHANGED=$( [ -n "$(echo "$BOOT_BACKUP_DATETIME" | tr -d '[:space:]')" ] && echo true || echo false)

echo "BOOTH CHANGED: " $BOOT_CHANGED

if [ $? -ne 0 ];
then
    echo "BOOT BACKUP FAILURE";
    BOOT_CHANGED="-1"
fi

# Run btrbk
sudo btrbk run

TIME_END=$(date "+%s")
TIME_TAKEN=$((TIME_END-TIME_START))

if [[ $? -eq 0 ]]
then
	echo -n "SUCCESS" >> $LOG_FILE # Log success

else
	echo "FAILURE" >> $LOG_FILE # Log failure
    exit $?
fi

# Log the date and time taken to complete backup.
echo -n ": " $(date) " Completed in: ${TIME_TAKEN}s">> $LOG_FILE # Log timestamp

if [ $BOOT_CHANGED = "-1" ];
then
    echo " /boot changed - BACKUP FAILED!" >> $LOG_FILE;
elif [ $BOOT_CHANGED = true ];
then
    echo " /boot changed - BACKUP: $BOOT_BACKUP_DATETIME" >> $LOG_FILE;
else
    echo "" >> $LOG_FILE;
fi