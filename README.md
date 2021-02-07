docker-kafka
============
A docker image for [Apache Kafka](https://kafka.apache.org/). To build an image using this docker file, execute the following command

    $ docker build -t lgslm/kafka .

To run a container and log into it execute the command
 
    $ docker run --rm -it --name kafka lgslm/kafka bash

Kafka needs to connect to Zookeeper to start so it is better started using docker-compose

    $ docker-compose up

It is possible to check the Kafka container by opening a new shell and executing the command

    $ docker exec -it kafka bash

A docker network must be created before running the services so that other containers that use the services will be able to connect by using the 
services' host names 

    $ docker network create pilot-sc4-net

In order to check whether Kafka is working properly you can create a topic, if not already available, and write and read messages. Follow the instruction
in [Apache Kafka Quickstart](https://kafka.apache.org/quickstart). 
