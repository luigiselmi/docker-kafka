docker-kafka
============
A docker image for [Apache Kafka](https://kafka.apache.org/). Kafka needs to connect to Zookeeper to start so it is better started using docker-compose

    $ docker-compose up

It is possible to check the Kafka container by opening a new shell and executing the command

    $ docker exec -it kafka bash

In order to check whether Kafka is working properly you can create a topic, if not already available and write and read messages. Follow the instruction
in [Apache Kafka Quickstart](https://kafka.apache.org/quickstart). 
