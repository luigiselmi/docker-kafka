docker-kafka
============
A docker image for [Apache Kafka](https://kafka.apache.org/). 

## standalone (one Zookeeper server and one Kafka broker)
To build an image using this docker file, execute the following command

    $ docker build -t lgslm/kafka:v1.0.0 .

To run a container and log into it execute the command
 
    $ docker run --rm -it --name kafka lgslm/kafka:v1.0.0 bash

Kafka needs to connect to Zookeeper to start so it is better started using docker-compose

    $ docker-compose up

It is possible to check the Kafka container by opening a new shell and executing the command

    $ docker exec -it kafka bash

A docker network must be created before running the services so that other containers in the same network that use the services will be able to connect 
by using the services' host names 

    $ docker network create kafka-clients-net

In order to check whether Kafka is working properly you can create a topic, if not already available, and write and read messages. Follow the instruction
in [Apache Kafka Quickstart](https://kafka.apache.org/quickstart). 

## Zookeeper cluster
A docker-compose file is available to run one Kafka broker connected to a cluster of three Zookeeper server containers

    $ docker stack deploy -c docker-compose-zk-cluster.yml zk-kafka-stack

## Kafka cluster
A docker-compose file is available to run two Kafka brokers connected to a cluster of three Zookeeper server containers

    $ docker stack deploy -c docker-compose-zk-kafka-clusters.yml zk-kafka-stack
