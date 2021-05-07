#!/bin/bash -e

echo "Run backup"
date=$(date "+%Y-%m-%dT%H:%M:%SZ")
filename=${BACKUP_FILE_PREFIX}-backup-${date}

echo "mysqldump -h ${MYSQL_HOST} -P ${MYSQL_PORT} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --all-databases > ${filename}"
mysqldump -h "${MYSQL_HOST}" -P "${MYSQL_PORT}" -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --all-databases > "${filename}"

tar -czvf ${filename}.tar.gz ${filename}

gcloud auth activate-service-account --key-file=${GCS_KEYFILE_PATH}
gsutil cp /temp/${filename}.tar.gz ${GCS_BUCKET}/${filename}.tar.gz

echo "Finished backup"