# Args: vg_group/thin-pool-vol

sudo lvs -o data_percent,metadata_percent $1 | tail -n 1 | awk '{ print "vm-pool: " $1 "%/" $2 "%" }'