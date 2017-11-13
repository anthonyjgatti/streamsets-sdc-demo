
FROM streamsets/datacollector:2.7.2.0
USER root

# Install desired jars.
ENV SDC_VERSION 2.7.2.0
ENV SDC_LIBS jdbc

RUN for i in $SDC_LIBS; \
  do /opt/streamsets-datacollector-${SDC_VERSION}/libexec/_stagelibs \
  -install=streamsets-datacollector-$i-lib; done

# Install MySQL JDBC driver.
RUN mkdir -p /opt/sdc-extras/streamsets-datacollector-jdbc-lib/lib && \
  chown -R sdc:sdc /opt/sdc-extras

RUN curl -L -o /tmp/mysql-connector-java-5.1.44.tar.gz \
  http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.44.tar.gz && \
  tar -xf /tmp/mysql-connector-java-5.1.44.tar.gz -C /tmp

RUN cp /tmp/mysql-connector-java-5.1.44/mysql-connector-java-5.1.44-bin.jar \
  /opt/sdc-extras/streamsets-datacollector-jdbc-lib/lib

RUN echo 'export STREAMSETS_LIBRARIES_EXTRA_DIR="/opt/sdc-extras"' \
  >> /opt/streamsets-datacollector-${SDC_VERSION}/libexec/sdc-env.sh && \
  echo 'export STREAMSETS_LIBRARIES_EXTRA_DIR="/opt/sdc-extras"' \
  >> /opt/streamsets-datacollector-${SDC_VERSION}/libexec/sdcd-env.sh

# Hacking my way through life
RUN echo 'grant codebase "file:///opt/sdc-extras/-" {' >> /etc/sdc/sdc-security.policy \
  && echo '  permission java.security.AllPermission;' >> /etc/sdc/sdc-security.policy \
  && echo '};' >> /etc/sdc/sdc-security.policy

# Restart the data collector. Env may not be necessary.
ENV STREAMSETS_LIBRARIES_EXTRA_DIR="/opt/sdc-extras"
CMD ["dc", "-exec"]
