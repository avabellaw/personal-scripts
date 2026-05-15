for x in $@; do sudo btrfs subvol create /mnt/btrfsroot/@$x/.@DEL_LOCK; sudo chattr +i /mnt/btrfsroot/@$x/.@DEL_LOCK; done
