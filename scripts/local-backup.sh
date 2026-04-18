#!/bin/bash

DATE=$(date +%Y-%m-%d)
BACKUP_DIR="/home/kenan/nightscout-backups"
CONTAINER="nightscout-mongo"

mkdir -p $BACKUP_DIR

docker exec $CONTAINER mongodump --out /tmp/dump
docker cp $CONTAINER:/tmp/dump $BACKUP_DIR/nightscout-$DATE
docker exec $CONTAINER rm -rf /tmp/dump

# Keep only last 30 days
find $BACKUP_DIR -maxdepth 1 -name "nightscout-*" -mtime +30 -exec rm -rf {} \;

echo "Backup complete: nightscout-$DATE"