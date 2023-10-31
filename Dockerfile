FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y wget curl bash nodejs zip && \
    # Install helm
    curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > /tmp/get_helm.sh && \
    chmod 700 /tmp/get_helm.sh && \
    /tmp/get_helm.sh && \
    rm /tmp/get_helm.sh && \
    # Install Docker
    RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io
    # Install oc client
    cd /tmp && \
    wget https://github.com/openshift/origin/releases/download/v3.6.1/openshift-origin-client-tools-v3.6.1-008f2d5-linux-64bit.tar.gz -O oc.tgz && \
    tar --overwrite --strip 1 -C /usr/local/bin -zxvf oc.tgz && \
    rm -f oc.tgz
