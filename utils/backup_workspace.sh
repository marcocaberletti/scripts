#!/bin/sh

BASEDIR=/home/marco/workspace
DEST_FILE=/home/backup/marco/workspace/workspace_$(date +'%Y-%m-%d_%H%M%S').tar.gz
#SRV_DIR=//artemide/Users/mcaberletti

echo "Starting backup on "$(date)

cd $BASEDIR
tar czf $DEST_FILE -C $BASEDIR * \
  --exclude=*.class \
  --exclude=*.gz \
  --exclude=*.jar \
  --exclude=*.log \
  --exclude=*git* \
  --exclude=*metadata* \
  --exclude=*.exe \
  --exclude=*.zip \
  --exclude=*.pdf \
  --exclude=*deploy* \
  --exclude='RemoteSystemsTempFiles' \

echo "Archive done"

#if [ -d "$SRV_DIR" ]
#then
#  echo 'Upload archive...'
#  cp $DEST_FILE $SRV_DIR/
#fi

echo "Finished on "$(date)
