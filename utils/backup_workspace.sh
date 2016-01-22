#!/bin/sh

BASEDIR=/home/marco/workspace
DEST_FILE=/home/backup/marco/workspace/workspace_$(date +'%Y-%m-%d_%H%M%S').tar.gz

echo "Starting backup on "$(date)

cd $BASEDIR
tar czf $DEST_FILE -C $BASEDIR * \
  --exclude=*.class \
  --exclude=*.gz \
  --exclude=*.jar \
  --exclude=*.war \
  --exclude=*.log \
  --exclude=*git* \
  --exclude=*metadata* \
  --exclude=*.exe \
  --exclude=*.zip \
  --exclude=*.pdf \
  --exclude=*deploy* \
  --exclude='RemoteSystemsTempFiles' \
  --exclude=*target* \

echo "Archive done"


echo "Finished on "$(date)
