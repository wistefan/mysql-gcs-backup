# Backup mysql to gcs

A simple job to backup a complete mysql instance into gcs-bucket. 

## Config

Following environment  variables are supported:

|  Env-Var | Description | Default |
| ----------------- | ----------------------------------------------- | ------------------------ |             
| BACKUP_FILE_PREFIX | Prefix to be used for the tar-file. Will create a name in form of ```<Prefix>-backup-<date>.tar.gz```     |  backup   |
| GCS_KEYFILE_PATH | Path to the serviceaccount json file to be used for the bucket. | /gcs/credentials.json |
| GCS_BUCKET | Name of the backet to be used. | null |
| MYSQL_HOST | Host of the mysql instance | localhost  |
| MYSQL_PORT | Port of the mysql instance | 3306  |
| MYSQL_USER | User for accessing the mysql instance | root  |
| MYSQL_PASSWORD | Password for accessing the mysql instance | password  |