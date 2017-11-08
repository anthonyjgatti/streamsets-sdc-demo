
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

# A Common Data Architecture.


# Features and Capabilities.

# Using SDC.

# Under the Hood.

* Pipelines generate JSON that gets translated into programs that run on the JVM.
* Pipelines are stateful => the "offset" determines what the pipeline has already processed.

# The Use Case

# DEMO



# Some future use cases.

1. Change data capture on a relational database.
2. Scaling out sdc on Kubernetes.
3. Using the StreamSets Python SDK to generate pipelines programmatically.

# Common pitfalls with the data collector.

1. Problems with data locality.
2. Race conditions on file writes.
3.
