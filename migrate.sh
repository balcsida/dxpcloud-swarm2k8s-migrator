#!/bin/sh
echo "SWARM_PROJECT_NAME:         $SWARM_PROJECT_NAME"
echo "SWARM_BACKUP_ID:            $SWARM_BACKUP_ID"
echo "SWARM_PROJECT_MASTER_TOKEN: $SWARM_PROJECT_MASTER_TOKEN"
echo "LCP_USER_ID:                $LCP_USER_ID"
echo "LCP_PROJECT_ID:             $LCP_PROJECT_ID"
echo "LCP_PROJECT_MASTER_TOKEN:   $LCP_PROJECT_MASTER_TOKEN"

echo 'Downloading database backup...'
curl -fX POST \
'https://backup-'"$SWARM_PROJECT_NAME"'-prd.us-west-1.lfr.cloud/backup/download/database/'"$SWARM_BACKUP_ID"'' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer '"$SWARM_PROJECT_MASTER_TOKEN"'' \
  --output database.tgz

if [ $? -eq 0 ]; then
  echo 'Database backup downloaded successfully'
else
  echo 'Failed to download database backup'
  echo 'Please delete this service and try again'
  tail -f /dev/null
fi

echo 'Downloading volume backup...'
curl -fX POST \
'https://backup-'"$SWARM_PROJECT_NAME"'-prd.us-west-1.lfr.cloud/backup/download/volume/'"$SWARM_BACKUP_ID"'' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer '"$SWARM_PROJECT_MASTER_TOKEN"'' \
  --output volume.tgz

if [ $? -eq 0 ]; then
  echo 'Volume backup downloaded successfully'
else
  echo 'Failed to download volume backup'
  echo 'Please delete this service and try again'
  tail -f /dev/null
fi

echo 'Applying backups to current project "'"$LCP_PROJECT_ID"'...'
curl -fX POST \
'https://backup-'"$LCP_PROJECT_ID"'.lfr.cloud/backup/upload' \
  -H 'Content-Type: multipart/form-data' \
  -H 'Authorization: Bearer '"$LCP_PROJECT_MASTER_TOKEN"'' \
  -F database=@database.tgz \
  -F volume=@volume.tgz \
  -F userId=$LCP_USER_ID

if [ $? -eq 0 ]; then
  echo 'Migration from Swarm to Kubernetes completed!'
  echo 'Please delete this service now from prd'
else
  echo 'Failed to apply backup on Kubernetes'
  echo 'Please delete this service and try again'
fi

tail -f /dev/null