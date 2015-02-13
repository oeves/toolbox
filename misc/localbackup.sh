#!/bin/bash

## incremental backup via rsync

YESTERDAY=$(date +%u_%A -d "yesterday")
TODAY=$(date +%u_%A)
SOURCE=/mnt/data/share
DESTINATION=/mnt/backup

rsync -aP --delete --link-dest=$DESTINATION/$YESTERDAY $SOURCE $DESTINATION/$TODAY

rm $DESTINATION/current.backup
ln -s $DESTINATION/$TODAY $DESTINATION/current.backup
