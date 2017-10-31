
# Hello!

* Me: Anthony Gatti.
* Live in Akron, OH.
* I am big fan of Cleveland sports and loud music.
* Today => Introducing the StreamSets Data Collector (sdc).

# About StreamSets.


# Introducing the StreamSets Data Collector.

* sdc is a tool to move data from one place to another in a near-continuous fashion.
* The main primitive is the pipeline.
* Pipelines have origins, processors, and destinations (also executors and parameters).

# Under the Hood.

* Pipelines generate JSON that gets translated into programs that run on the JVM.
* Pipelines are stateful => the "offset" determines what the pipeline has already proccessed.

# Use cases to examine today.

1. Reading log files and writing to Solr.
2. Reading zipped csv files and writing to Hive tables.
3. Real time web scraping of Spotify API.

# Some future use cases.

1. Change data capture on a relational database.
2. Scaling out sdc on Kubernetes.
3. Using the StreamSets Python SDK to generate pipelines programmatically.

# Common pitfalls with the data collector.

1. Problems with data locality.
2. Race conditions on file writes.
3. 

