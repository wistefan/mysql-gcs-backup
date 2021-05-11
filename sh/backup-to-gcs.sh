#!/bin/bash -e

echo "Run backup"
date=$(date "+%Y-%m-%dT%H:%M:%SZ")
filename=${BACKUP_FILE_PREFIX}-backup-${date}

mysqldump -h "${MYSQL_HOST}" -P "${MYSQL_PORT}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --all-databases > "/temp/${filename}"

tar -czvf /temp/${filename}.tar.gz /temp/${filename}

gcloud auth activate-service-account --key-file=${GCS_KEYFILE_PATH}
gsutil -o "GSUtil:state_dir=/temp/.gsutil" cp /temp/${filename}.tar.gz ${GCS_BUCKET}/${filename}.tar.gz

echo "Finished backup"