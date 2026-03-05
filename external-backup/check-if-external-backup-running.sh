# This is for Executor to show when external drive in the middle of backing up

if [[ $(systemctl status trigger-external-backup.service | grep -n "running") ]]; then echo "External backup running<executor.css.red>"; fi