FROM alpine:3.9

#Versions
ENV KUBECTL_VERSION="1.11.5/2018-12-06"
ENV AWS_VERSION="1.16.111"
ENV HELM_VERSION="2.12.3"
ENV HELM_TILLER_VERSION="0.6.7"
ENV HELM_DIFF_VERSION="v2.11.0+3"

#Install Packages
RUN apk add --no-cache bash curl git groff make ca-certificates less jq python3

#kubectl
RUN curl https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    curl https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/bin/linux/amd64/aws-iam-authenticator -o /usr/local/bin/aws-iam-authenticator && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/aws-iam-authenticator    

#helm
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar -xvz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    helm init -c && \
    helm plugin install https://github.com/rimusz/helm-tiller --version ${HELM_TILLER_VERSION}  && \
    helm plugin install https://github.com/databus23/helm-diff --version ${HELM_DIFF_VERSION} && \
    helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator && \
    rm -rf linux-amd64

#aws-cli
RUN pip3 install awscli==${AWS_VERSION}

#General Setup
RUN mkdir /work
WORKDIR /work

#Inject test script
COPY run_tests.sh /run_tests.sh

CMD ["/bin/bash"]