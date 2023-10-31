# Use a base image, such as Debian-based image
FROM debian:bullseye-slim

# Set environment variables (optional)
ENV OC_VERSION="4.8.6"
ENV HELM_VERSION="3.7.0"

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    software-properties-common

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

# Install OpenShift 'oc' client
RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OC_VERSION}/openshift-client-linux-${OC_VERSION}.tar.gz \
    && tar -xvf openshift-client-linux-${OC_VERSION}.tar.gz -C /usr/local/bin/ oc \
    && rm openshift-client-linux-${OC_VERSION}.tar.gz

# Install Helm
RUN curl -LO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xvf helm-v${HELM_VERSION}-linux-amd64.tar.gz -C /usr/local/bin/ linux-amd64/helm \
    && rm helm-v${HELM_VERSION}-linux-amd64.tar.gz

# Clean up
RUN apt-get purge -y curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory (optional)
WORKDIR /app

# Default command (optional)
CMD ["bash"]
