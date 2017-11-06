
FROM streamsets/datacollector:latest
USER root

# Create landing zone folder and install Python.
RUN mkdir -p /landing_zone \
    && apk add --update python py-pip \
    && chown sdc:sdc /landing_zone

# Create location for Python.
COPY /scripts/* .
RUN chown -R sdc:sdc demo.py \
    && pip install faker

# Add backup json pipelines.
# COPY /pipelines/*.json /var/lib/sdc/data/pipelines

# Enter as user sdc.
USER sdc

