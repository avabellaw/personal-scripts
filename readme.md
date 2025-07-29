# Personal script files

## Script descriptions

- run-btrbk.sh - Runs btrbk and creates own simplified log. Notifys if backup failed.

### bin

- get-last-backup - Searches **$BACKUP_DIR** and returns the lastest backup's datetime [DD/MM HH:MM].
- check-last-backup - **get-last-backup dependancy** For executor Gnome extension: Displays last backup, in red if been over 60 minutes. 

## Set up backup scripts

Backups are sent to an external drive using btrbk. It's an incremental backup using btrfs send/receive through btrbk.
Snaphots are created on the drive that contains the subvolumes. They are then sent to the external drive incrementally.

This means that snapshots are stored on both the drive being backed up and the backup drive.

### BACKUP_DIR enviroment variable

Set an enviorment variable in /etc/environment called "BACKUP_DIR" to target backup dir.

```sudo -H gedit /etc/environment```

_Always use -H when editings files as root to avoid junk going into the Home folder ~/.config_'

### Add ~/Scripts/bin to PATH

In /etc/environment, add /home/[user]/Scripts/bin to the end of PATH var - **Works for user and GUI apps such as executor**.

Use sudo visudo to add /home/[user]/Scripts/bin to secure path - **Works for sudo/root** 

| Directory | Scope |
| --------- | ----- |
| /etc/environment | System-wide: all users and programs |
| ~/.bashrc | Per-user, interactice bash shell only |
| visudo | secure path: sudo/root |