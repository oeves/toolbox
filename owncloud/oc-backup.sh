#!/bin/bash

## owncloud incremental backup script v1
## requires working PubkeyAuthentication
## how to run: ./oc_backup.sh cloud.yourdomain.com

## known issues:
## script doesnt backup owncloud data directory when its outside the owncloud installation

YESTERDAY=$(date +%u_%A -d "yesterday")
TODAY=$(date +%u_%A)
REMOTEHOST=$1
REMOTEUSER=root
REMOTEPATH=/var/www/owncloud
DESTINATION=/root/oc_backup
DBPASSWORD=$(cat $DESTINATION/$TODAY/owncloud/config/config.php | grep dbpassword | awk -F\' '{print $4}')
DBUSER=$(cat $DESTINATION/$TODAY/owncloud/config/config.php | grep dbuser | awk -F\' '{print $4}')
DBNAME=$(cat $DESTINATION/$TODAY/owncloud/config/config.php | grep dbname | awk -F\' '{print $4}')

rsync -aP --delete --link-dest=$DESTINATION/$YESTERDAY $REMOTEUSER@$REMOTEHOST:$REMOTEPATH $DESTINATION/$TODAY
ssh -l $REMOTEUSER $REMOTEHOST "mysqldump -u$DBUSER -p$DBPASSWORD $DBNAME | gzip -3 -c" > $DESTINATION/$TODAY/owncloud.sql.gz

rm $DESTINATION/current.backup
ln -s $DESTINATION/$TODAY $DESTINATION/current.backup
