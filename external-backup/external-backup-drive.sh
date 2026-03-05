#!/bin/bash

# Essentially has to be run as root inorder to perform the btrbk operations required. Therefore I have to setup notify-send in this way to send notifications to my user.

NOTIFICATION_TITLE="External drive btrbk"
NOTIFY_USER=ava

/usr/bin/sudo -u $NOTIFY_USER DISPLAY=:0 \
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $NOTIFY_USER)/bus \
/usr/bin/notify-send "$NOTIFICATION_TITLE" "Backup started"

btrbk archive /mnt/btrfsroot/.btrbk-snapshots /media/external-backup

if [[ $? -eq 0 ]]; then
	/usr/bin/sudo -u $NOTIFY_USER DISPLAY=:0 \
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $NOTIFY_USER)/bus \
/usr/bin/notify-send "$NOTIFICATION_TITLE" "Backup successful";
else
	/usr/bin/sudo -u $NOTIFY_USER DISPLAY=:0 \
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $NOTIFY_USER)/bus \
/usr/bin/notify-send "$NOTIFICATION_TITLE" "Backup error";
fi
