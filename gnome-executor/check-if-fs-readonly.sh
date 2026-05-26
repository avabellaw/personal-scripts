#!/bin/bash

if [[ $(mount | grep "/dev/mapper/data-root" | awk '{ print $6}' | grep -n "(ro") ]]; then echo "Filesystem in readonly";fi
