---
layout: post
title: Belajar AWS Data Analytics Speciality DAS-CO1
description: "Belajar AWS Data Analytics Speciality DAS-CO1"
tags: [certification, aws, certification aws, aws data analytics speciality]
image:
  background: triangular.png
---

## Cheatsheet

- Redshift Spectrum
A Redshift feature that allows users to run queries against data stored on Amazon S3.

- Geospatial chart
A QuickSight visual type that is best suited for displaying different data values across a geographical map.

- Amazon Kinesis
Data Streams that can collect and process large streams of data records in real time.

- Amazon Macie
A fully managed data security and data privacy service that uses machine learning and pattern matching to discover and protect your sensitive data in AWS.

- Amazon Athena
An interactive query service that makes it easy to analyze data in Amazon S3 using standard SQL.

- True
True or False. A single COPY command is faster than multiple COPY commands when loading one Redshift table from multiple files.

- AWS Glue
A serverless data integration service that makes it easy to discover, prepare, and combine data for analytics, machine learning, and application development.
Not studied (3)You haven't studied these terms yet!

- Per-query limit
A form of cost control in Amazon Athena that limits the amount of data scanned per query.

- Amazon S3
An AWS service that is used as a referenced data source for a Kinesis Data Analytics application?

- Amazon S3 Glacier
A secure, durable, and extremely low-cost Amazon S3 storage class for data archiving and long-term backup.

Types of Data Collection
1. Real Time
2. Near Real Time
3. Batch

Real Time Data Collection Services
1. Kinesis Data Streams
2. Simple Queue Service
3. Internet of Things

Near Real Time Collection Services
1. Kinesis Data Firehose
2. Database Migration Service

Batch Collection Services
1. Snowball
2. Data Pipeline

Kineses Services
1. Kinesis Streams
2. Kinesis Analytics
3. Kinesis Firehose

Kinesis Streams
1. Steams are divided in ordered Shards
2. Data retention is 24 hours by default, 7 day max
3. Ability to reprocess data within the data retention period
4. Once data is inserted, it cannot be deleted

Kinesis Streams Records
1. Data Blob
2. Record Key
3. Sequence Number

Data Blob
Data being sent, serialized as bytes. Up to 1MB. Can represent anything

Record Key
1. Sent alongside a record, helps to group records in Shards. Same key = Same shard
2. Use a highly distributed key to avoid the "hot partition" problem

Sequence Number
Unique identifier for each records put in shards. Added by Kinesis after ingestion

Kinesis Streams Limits (Producer)
1MB/s or 1000 messages/s at write per shard.

Kinesis Producer Components
1. Kinesis SDK
2. Kinesis Producer Library (KPL)
3. Kinesis Agent
4. 3rd Party Libraries

Kinesis Streams Limits (Consumer Classic)
2MB/s or 5 API calls/s per shard across all consumers

Kinesis Streams Limits (Consumer Enhanced)
2MB/s per shard, per enhanced consumer. No API calls needed

Kinesis Producer SDK (PutRecord(s))
1. API's that are used are PutRecord (one) and PutRecords (many records).
2. PutRecords uses batching and increases throughput (less HTTP requests)

Kinesis Producer SDK (Use Cases)
1. Low throughput
2. Higher latency
3. Simple API
4. AWS Lambda

Kinesis Data Streams (Manage AWS Services)
1. CloudWatch Logs
2. AWS IoT
3. Kinesis Data Analytics

ProvisionThroughputExceeded Exceptions
Problem:
Happens when sending more data (exceeding MB/s or TPS for any shard)
Make sure you don't have a hot shard (such as your partition key is bad and too much data goes to that partition
Solution:
1. Retries with backoff
2. Increase shards (scaling)
3. Ensure partition key is distributed

Kinesis Producer Library (KPL)
1. Easy to use highly configurable C++/Java library
2. Used for building high performance, long-running producers
3. Automated and configurable retry mechanism
4. Synchronous or Asynchronous API
5. Submits metrics to CloudWatch for monitoring
6. Batching - increase throughput, decrease cost
7. Compression must be implemented by user
8. KPL Records must be de-coded with KCL or special helper library

Kinesis Agent
1. Monitor Log files and sends them to Kinesis Data Streams
2. Java-based agent, built on top of KPL
3. Install Linux-based server environments
4. Write from multiple directories and write to multiple streams
5. Routing based on directory/ log file
6. Pre-process data before sending to streams
7. The agent handles file rotation, checkpointing, and retry up failures
8. Emits metrics to CloudWatch for monitoring

Kinesis Consumers Classic Components
1. Kinesis SDK
2. Kinesis Client Library
3. Kinesis Connector Library
4. 3rd party libraries
5. Kinesis Firehose
7. AWS Lambda

Kinesis Consumer Classic SDK (GetRecords)
1. Records are polled by consumers from a shard
2. Each shard has 2MB total aggregate throughput
3. GetRecords returns up to 10MB/s of data (then throttle for 5 seconds) or up to 10K records/s
4. Maximum of 5 GetRecords API calls per shard per second = 200ms latency
5. If 5 consumer applications consume from the same shard, means every consumer can poll once a second and receive less than 400KB/s

Kinesis Client Library


# Lanjutan (Masih dalam penulisan)

Refferences : 
- https://quizlet.com/search?query=aws-data-analytics-specialty&type=sets&useOriginal=