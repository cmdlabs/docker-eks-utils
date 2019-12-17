FROM alpine:3.10

#Versions
ENV KUBECTL_VERSION="1.14.6/2019-08-22"
ENV AWS_VERSION="1.16.290"
ENV AWS_VERSION="1.16.191"
ENV HELM_VERSION="3.0.1"
ENV HELM_DIFF_VERSION="3.0.0-rc.7"

#Install Packages
RUN apk add --update --no-cache bash bash-completion curl git make ca-certificates less jq python3 coreutils gettext-dev

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
RUN mkdir /work
WORKDIR /work

#Inject test script
COPY run_tests.sh /run_tests.sh

CMD ["/bin/bash"]
