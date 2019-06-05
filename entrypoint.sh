#!/bin/sh

if [ $LCP_PROJECT_ENVIRONMENT -ne 0 ]; then
  echo 'Please deploy this service to the "prd" environment!'
  exit 1
fi

echo 'Downloading database backup...'
curl -X POST \
'https://backup-'"$SWARM_PROJECT_NAME"'-prd.us-west-1.lfr.cloud/backup/download/database/'"$SWARM_BACKUP_ID"'' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer '"$SWARM_PROJECT_MASTER_TOKEN"'' \
  --output database.tgz

echo 'Downloading volume backup...'
curl -X POST \
'https://backup-'"$SWARM_PROJECT_NAME"'-prd.us-west-1.lfr.cloud/backup/download/volume/'"$SWARM_BACKUP_ID"'' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer '"$SWARM_PROJECT_MASTER_TOKEN"'' \
  --output volume.tgz

echo 'Applying backups to current project "'"$LCP_PROJECT_ID"'...'
curl -X POST \
'https://backup-'"$LCP_PROJECT_ID"'.lfr.cloud/backup/upload' \
  -H 'Content-Type: multipart/form-data' \
  -H 'Authorization: Bearer '"$LCP_PROJECT_MASTER_TOKEN"'' \
  -F database=@database.tgz \
  -F volume=@volume.tgz \
  -F userId=$LCP_USER_ID

echo 'Migration from Swarm to Kubernetes completed!'
echo 'Please remove this service now from '