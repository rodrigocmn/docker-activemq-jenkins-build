FROM centos
MAINTAINER Rodrigo Nascimento (rodrigo@rnascimento.com)

# Application settings
ENV APP_HOME="/opt/activemq" \
    APP_VERSION="5.15.3" \
    USER=activemq \
    GROUP=activemq \
    UID=10003 \
    GID=10003 \
    CONTAINER_NAME="centos-oraclejdk-activemq" \
    CONTAINER_AUHTOR="Rodrigo Nascimento <rodrigo@rnascimento.com>" \
    JAVA_HOME="/usr/lib/jvm/jre-openjdk"

# Install pre-requisites
RUN yum -y update; yum clean all &&\
    yum -y install systemd java-1.8.0-openjdk &&\
    yum clean all &&\
    rm -rf /var/cache/yum &&\
    yum clean all

# Install Active MQ
RUN \
    mkdir -p ${APP_HOME} /data /var/log/activemq  && \
    curl http://apache.mirrors.ovh.net/ftp.apache.org/dist/activemq/${APP_VERSION}/apache-activemq-${APP_VERSION}-bin.tar.gz -o /tmp/activemq.tar.gz &&\
    tar -xzf /tmp/activemq.tar.gz -C /tmp &&\
    mv /tmp/apache-activemq-${APP_VERSION}/* ${APP_HOME} &&\
    rm -rf /tmp/activemq.tar.gz &&\
    groupadd -g ${GID} ${GROUP} && \
    useradd -g "${GROUP}" -d ${APP_HOME} -G ${GROUP} -s /bin/sh -u ${UID} ${USER}

COPY  config/activemq.xml /opt/activemq/conf

# Change folders permissions
RUN \
    chown -R ${USER}:${GROUP} ${APP_HOME} &&\
    chown -R ${USER}:${GROUP} /data &&\
    chown -R ${USER}:${GROUP} /var/log/activemq

# Expose all port
EXPOSE 8161:8161
EXPOSE 61616:61616
EXPOSE 5672:5672
EXPOSE 61613:61613
EXPOSE 1883:1883
EXPOSE 61614:61614

VOLUME ["/data", "/var/log/activemq"]
WORKDIR ${APP_HOME}
CMD ["/bin/sh", "-c", "bin/activemq console"]
