# StreamSets Data Collector - Demo.

A demo of the StreamSets Data Collector, using Docker and `docker-compose` with:

* The [mysql Docker image](https://hub.docker.com/_/mysql/) (version 5.6).
* The [StreamSets Data Collector Docker image](https://hub.docker.com/r/streamsets/datacollector/) (built on SDC version 2.7.2.0).

The bash script `sdc_demo_helper.sh` orchestrates the demo stages, and `demo.py` generates the example data.
