FROM alpine:3.10

#Versions
ENV KUBECTL_VERSION="1.14.6/2019-08-22"
ENV AWS_VERSION="1.16.290"
ENV HELM_VERSION="2.16.1"
ENV HELM_TILLER_VERSION="0.9.3"
ENV HELM_DIFF_VERSION="v2.11.0+5"
ENV KUBECTX_VERSION="0.7.1"
ENV VELERO_VERSION="1.2.0"

#Install Packages
RUN apk add --update --no-cache bash bash-completion curl git groff make ca-certificates less jq python3 fzf ncurses coreutils gettext-dev

#kubectl
RUN curl -L https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

#helm
RUN curl -L https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz && \
    tar -xvzf /tmp/helm.tar.gz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    mv /tmp/linux-amd64/tiller /usr/local/bin/tiller && \
    chmod +x /usr/local/bin/helm && \
    chmod +x /usr/local/bin/tiller && \
    helm init -c && \
    helm plugin install https://github.com/rimusz/helm-tiller --version ${HELM_TILLER_VERSION}  && \
    helm plugin install https://github.com/databus23/helm-diff --version ${HELM_DIFF_VERSION} && \
    helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator && \
    rm -rf /tmp/*

#aws-cli
RUN pip3 install awscli==${AWS_VERSION}

#kubectx
RUN curl -L https://github.com/ahmetb/kubectx/archive/v${KUBECTX_VERSION}.tar.gz -o /tmp/kubectx.tar.gz && \
    tar -xvzf /tmp/kubectx.tar.gz -C /tmp && \
    mv /tmp/kubectx-${KUBECTX_VERSION}/kubectx /usr/local/bin/kubectx && \
    mv /tmp/kubectx-${KUBECTX_VERSION}/kubens /usr/local/bin/kubens && \
    chmod +x /usr/local/bin/kubectx && \
    chmod +x /usr/local/bin/kubens && \
    mv /tmp/kubectx-${KUBECTX_VERSION}/completion/kubectx.bash /usr/share/bash-completion/completions/kubectx.bash && \
    mv /tmp/kubectx-${KUBECTX_VERSION}/completion/kubens.bash /usr/share/bash-completion/completions/kubens.bash && \
    rm -rf /tmp/*

#velero
RUN curl -L https://github.com/heptio/velero/releases/download/v${VELERO_VERSION}/velero-v${VELERO_VERSION}-linux-amd64.tar.gz -o /tmp/velero.tar.gz && \
    tar -xvzf /tmp/velero.tar.gz -C /tmp && \
    mv /tmp/velero-v${VELERO_VERSION}-linux-amd64/velero /usr/local/bin/velero && \
    chmod +x /usr/local/bin/velero && \
    rm -rf /tmp/*

#General Setup
RUN mkdir /work
WORKDIR /work

#Inject test script
COPY run_tests.sh /run_tests.sh

CMD ["/bin/bash"]
