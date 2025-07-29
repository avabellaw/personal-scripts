#!/bin/bash

# Runs btrbk and logs success/failure timestamp.

LOG_FILE=/var/log/btrbk.log

TIME_START=$(date "+%s")

sudo btrbk run

TIME_END=$(date "+%s")

TIME_TAKEN=$((TIME_END-TIME_START))

if [[ $? -eq 0 ]]
then
	echo -n "SUCCESS" >> $LOG_FILE # Log success
else
	echo -n "FAILURE" >> $LOG_FILE # Log failure
fi

echo ": " $(date) " Completed in: ${TIME_TAKEN}s">> $LOG_FILE # Log timestamp
