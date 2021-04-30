FROM mysql:5.7

ARG CLOUD_SDK_VERSION=338.0.0

ENV BACKUP_FILE_PREFIX backup
ENV GCS_KEYFILE_PATH /gcs/credentials.json
ENV MYSQL_HOST localhost
ENV MYSQL_PORT 3306
ENV MYSQL_USER root
ENV MYSQL_PASSWORD password

RUN apt-get update
RUN apt-get install -y python3 curl

RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
                                 tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
                                 rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz

ADD sh /sh
RUN chmod -R +x /sh

ENTRYPOINT ["/sh/backup-to-gcs.sh"]