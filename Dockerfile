FROM alpine:3.11

#Versions
ENV KUBECTL_VERSION="1.15.10/2020-02-22"
ENV AWS_VERSION="1.18.46"
ENV HELM_VERSION="3.2.0"
ENV HELM_DIFF_VERSION="3.1.1"

#Install Packages
RUN apk add --update --no-cache curl git make ca-certificates less jq python3 coreutils gettext-dev

#kubectl
RUN curl -sL https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

#helm
RUN curl -sL https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz && \
    tar -xvzf /tmp/helm.tar.gz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    helm repo add stable https://kubernetes-charts.storage.googleapis.com/ && \
    helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator && \
    helm plugin install https://github.com/databus23/helm-diff --version v${HELM_DIFF_VERSION} && \
    rm -rf /tmp/*

#aws-cli
RUN pip3 install --no-cache-dir awscli==${AWS_VERSION}

#General Setup
RUN mkdir -p /work
WORKDIR /work

ENTRYPOINT ["kubectl"]
