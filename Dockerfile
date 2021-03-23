FROM alpine:3.11

#Versions
ENV KUBECTL_VERSION="1.19.6/2021-01-05"
ENV AWS_VERSION="1.19.34"
ENV HELM_VERSION="3.5.3"
ENV HELM_DIFF_VERSION="3.1.3"
ENV HELM_S3_VERSION="0.10.0"
ENV HELM_SECRETS_VERSION="3.5.0"
ENV HELM_GIT_VERSION="0.10.0"
ENV HELMFILE_VERSION="v0.138.7"
ENV SOPS_VERSION="v3.6.1"

#Install Packages
RUN apk add --update --no-cache bash curl git groff make ca-certificates less jq python3 coreutils gettext-dev

#kubectl
RUN curl -sL https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

#sops
RUN curl -sL https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux > /usr/local/bin/sops && \
    chmod +x /usr/local/bin/sops

#helm
RUN curl -sL https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz && \
    tar -xvzf /tmp/helm.tar.gz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    helm repo add stable https://charts.helm.sh/stable/ && \
    helm repo add incubator https://charts.helm.sh/incubator && \
    helm plugin install https://github.com/databus23/helm-diff --version v${HELM_DIFF_VERSION} && \
    helm plugin install https://github.com/jkroepke/helm-secrets --version v${HELM_SECRETS_VERSION} && \
    helm plugin install https://github.com/hypnoglow/helm-s3.git --version v${HELM_S3_VERSION} && \
    helm plugin install https://github.com/aslafy-z/helm-git.git --version v${HELM_GIT_VERSION} && \
    rm -rf /tmp/*

#aws-cli
RUN pip3 install --no-cache-dir awscli==${AWS_VERSION}

#helmfile
RUN curl -sL https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 -o /usr/local/bin/helmfile && \
    chmod +x /usr/local/bin/helmfile

#General Setup
RUN mkdir -p /work
WORKDIR /work

ENTRYPOINT ["kubectl"]
