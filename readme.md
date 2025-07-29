# Personal script files

## Set up backup scripts

Set an enviorment variable in /etc/environment called "BACKUP_DIR" to target backup dir.

```sudo -H gedit /etc/environment```

_Always use -H when editings files as root to avoid junk going into the Home folder ~/.config_'

## Add ~/Scripts/bin to PATH

```sudo nano ~/.bashrc```

Add the following to the end of the file:

```PATH=$PATH:~/Scripts/bin```