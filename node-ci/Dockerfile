FROM makeomatic/node:10.9.0

# https://www.telepresence.io/reference/install#dependencies
# NOTE: python2 is required for gcloud and telepresence requires python3
RUN apk --no-cache add bash \
  python3 git openssh-client sshfs iptables conntrack-tools torsocks socat \
  python py-crcmod libc6-compat gnupg

ENV CLOUD_SDK_VERSION=216.0.0
ENV PATH /google-cloud-sdk/bin:$PATH
RUN wget -O gcloud.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar zxvf gcloud.tar.gz && \
    rm gcloud.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud components install kubectl docker-credential-gcr

ENV HELM_VERSION=2.10.0
RUN wget -O helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar zxvf helm.tar.gz && \
    rm helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    helm version -c

ENV HELMSMAN_VERSION=1.5.0
RUN wget -O helmsman.tar.gz https://github.com/Praqma/helmsman/releases/download/v${HELMSMAN_VERSION}/helmsman_${HELMSMAN_VERSION}_linux_amd64.tar.gz && \
    tar zxvf helmsman.tar.gz && \
    rm helmsman.tar.gz && \
    mv helmsman /usr/local/bin/helmsman && \
    helmsman -v

ENV TELEPRESENCE_VERSION=0.92
RUN wget -O telepresence.tar.gz https://github.com/telepresenceio/telepresence/archive/${TELEPRESENCE_VERSION}.tar.gz && \
  tar zxvf telepresence.tar.gz && \
  rm telepresence.tar.gz && \
  env PREFIX=/usr/local ./telepresence-${TELEPRESENCE_VERSION}/install.sh && \
  rm -R telepresence-${TELEPRESENCE_VERSION} && \
  telepresence --version
