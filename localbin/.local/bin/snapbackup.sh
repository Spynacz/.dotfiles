#!/bin/sh

OPT="-aPh"
LINK="--link-dest=snapshots/last"
SRC="/home/mateusz"
SNAP="snapshots"
LAST="snapshots/latest"
DATE=$(date "+%Y-%m-%d_%T")
EXCLUDE="--exclude=.cache --exclude=**Cache* --exclude=**cache*"

cd /run/media/mateusz/Samsung

rsync $OPT $EXCLUDE $LINK $SRC ${SNAP}/${DATE}

rm -f $LAST
ln -s ${SNAP}/${DATE} $LAST
