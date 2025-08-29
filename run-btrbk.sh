#!/bin/bash

# Runs btrbk and logs success/failure timestamp.

# REQUIRES:
# - btrfsroot to be mounted. This is done in btrbk.service.
# rsync-backup to be on program path.

LOG_FILE=/var/log/btrbk.log

TIME_START=$(date "+%s")

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

# Run rsync on /boot directory.
# Backing up to root means that the correct /boot version will be tied to each root snapshot.
backedup=$(/home/ava/Scripts/bin/rsync-backup /boot /boot-backup)

#If not empty
if [ -n "$(echo "$backedup" | tr -d '[:space:]')" ];
then
    echo " /boot changed - BACKUP: $backedup" >> $LOG_FILE;
else
    echo "" >> $LOG_FILE;
fi
