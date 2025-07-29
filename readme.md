# Personal script files

## Script descriptions

### bin

- get-last-backup - Searches $BACKUP_DIR and returns the lastest backup's date [DD/MM HH:MM].

## Set up backup scripts

Backups are sent to an external drive using btrbk. It's an incremental backup using btrfs send/receive through btrbk.
Snaphots are created on the drive that contains the subvolumes. They are then sent to the external drive incrementally.

This means that snapshots are stored on both the drive being backed up and the backup drive.

### BACKUP_DIR enviroment variable

Set an enviorment variable in /etc/environment called "BACKUP_DIR" to target backup dir.

```sudo -H gedit /etc/environment```

_Always use -H when editings files as root to avoid junk going into the Home folder ~/.config_'

### Add ~/Scripts/bin to PATH

Also in /etc/environment, add ~/Scripts/bin to the end of PATH var