
FROM streamsets/datacollector:latest
USER root

# Create landing zone folder and install Python.
RUN mkdir -p /landing_zone \
    && apk add --update python py-pip \
    && chown sdc:sdc /landing_zone \
    && pip install faker

# Install desired jars.
ENV SDC_VERSION 2.7.2.0
ENV SDC_LIBS jdbc mongodb_3

RUN for i in $SDC_LIBS; \
  do /opt/streamsets-datacollector-${SDC_VERSION}/libexec/_stagelibs \
  -install=streamsets-datacollector-$i-lib; done

# Restart the data collector.
CMD ["dc", "-exec"]
