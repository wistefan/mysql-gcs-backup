FROM mysql:5.7

ARG CLOUD_SDK_VERSION=338.0.0

ENV BACKUP_FILE_PREFIX=backup
ENV GCS_KEYFILE_PATH=/gcs/credentials.json
ENV MYSQL_HOST=localhost
ENV MYSQL_PORT=3306
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=password

RUN apt-get update
RUN apt-get install -y python3 curl


# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
ENV CLOUDSDK_CONFIG=/temp/.gcloud

ADD sh /sh
RUN mkdir /temp
RUN chmod -R a+rw /temp
RUN chmod -R +x /sh

ENTRYPOINT ["/sh/backup-to-gcs.sh"]