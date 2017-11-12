
FROM streamsets/datacollector:2.7.2.0
USER root

# Install desired jars.
ENV SDC_VERSION 2.7.2.0
ENV SDC_LIBS jdbc mongodb_3

RUN for i in $SDC_LIBS; \
  do /opt/streamsets-datacollector-${SDC_VERSION}/libexec/_stagelibs \
  -install=streamsets-datacollector-$i-lib; done

# Change ownership of data files.
RUN mkdir /usr/src/app && chown -R sdc:sdc /usr/src/app

# Restart the data collector.
CMD ["dc", "-exec"]
