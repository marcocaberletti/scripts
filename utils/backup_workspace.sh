#!/bin/sh

WORKSPACES="/home/marco/workspace /workspace"
DESTDIR=/home/marco/backup/workspace

idx=1;

for basedir in ${WORKSPACES}; do
	FILENAME=workspace-${idx}_`date +'%Y-%m-%d_%H%M%S'`.tar.gz
	DEST_FILE=${DESTDIR}/${FILENAME}

	echo "Starting backup of workspace-${idx} on "`date`

	cd ${basedir}
	tar czf ${DEST_FILE} -C ${basedir} * \
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
	  --exclude=*.rpm \
	  --exclude=*deploy* \
	  --exclude='RemoteSystemsTempFiles' \
	  --exclude=*target* \

	echo "Archive done"
	
	idx=$((idx + 1))
done

echo "Finished on "`date`

