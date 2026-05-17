#!/bin/bash

# Essentially has to be run as root inorder to perform the btrbk operations required. Therefore I have to setup notify-send in this way to send notifications to my user.

NOTIFICATION_TITLE="External drive btrbk"
NOTIFY_USER=ava

LAST_BACKUP_EPOCH_SECONDS=$(date -d "$(journalctl -u trigger-external-backup.service | grep "Backup successful" | tail -n 1 | cut -d " " -f8-)" +%s)
SECONDS_SINCE_BACKUP=$(($(date +%s) - LAST_BACKUP_EPOCH_SECONDS))

log() {
    # Create notification for user (this service has to be run as root).
    # Log to systemd service log. 
    /usr/bin/sudo -u $NOTIFY_USER DISPLAY=:0 \
    DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $NOTIFY_USER)/bus \
    /usr/bin/notify-send "$NOTIFICATION_TITLE" "$1";
    echo "$1";
}

if [[ $SECONDS_SINCE_BACKUP -gt 3600 ]]; then
    log "Backup started"

    btrbk archive /mnt/btrfsroot/.btrbk-snapshots /media/external-backup;

    if [[ $? -eq 0 ]]; then
        log "Backup successful: $(date "+%D %T %z")"
    else
        log "Backup error"
    fi
else 
    log "No backup needed"
fi
