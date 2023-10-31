# Use CentOS as the base image
FROM centos:latest

# Set the maintainer label
LABEL maintainer="your-email@example.com"

# Install required dependencies
RUN yum -y install epel-release && \
    yum -y install docker && \
    yum -y install wget && \
    rpm --import https://packages.cloud.google.com/yum/doc/yum-key.gpg && \
    yum -y install https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64.noarch.rpm && \
    yum -y install kubectl && \
    wget https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz && \
    tar -zxvf helm-v3.7.0-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf linux-amd64 && \
    yum clean all && \
    rm -rf /var/cache/yum

# Add a non-root user and switch to it
RUN useradd -m -r -u 1001 nonrootuser
USER nonrootuser

# Set the working directory to the user's home directory
WORKDIR /home/nonrootuser

# Create a directory for Helm charts
RUN mkdir -p /home/nonrootuser/.helm

# Copy any Helm configurations (if needed) to the user's home directory
# Example: COPY .helm/config.yaml /home/nonrootuser/.helm/config.yaml

# Ensure that Helm data directory is writable by the non-root user
RUN chmod -R 775 /home/nonrootuser/.helm

# Switch back to the non-root user for running commands
USER nonrootuser

# Set entry point to an interactive shell
CMD ["/bin/bash"]
