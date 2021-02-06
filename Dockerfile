# Dockerfile for Apache kafka
# To build an image using this docker file, execute the following command
#
# $ docker build -t lgslm/kafka .
#
# To run a container and log into it execute the command
# 
# $ docker run --rm -it --name kafka lgslm/kafka bash
#
FROM openjdk:8

MAINTAINER Luigi Selmi <luigi@datiaperti.it>

# Install Apache Kafka
COPY kafka_2.13-2.7.0.tgz /usr/local/kafka_2.13-2.7.0.tgz
WORKDIR /usr/local/
RUN tar xvf kafka_2.13-2.7.0.tgz
RUN rm kafka_2.13-2.7.0.tgz
ENV KAFKA_HOME=/usr/local/kafka_2.13-2.7.0

# Install  network tools (ifconfig, netstat, ping, ip)
RUN apt-get update && \
    apt-get install -y net-tools && \
    apt-get install -y iputils-ping && \
    apt-get install -y iproute2 && \
    apt-get install -y netcat

# Install vi for editing
RUN apt-get update && \
    apt-get install -y vim

# Create a simbolic link to Kafka
RUN ln -s $KAFKA_HOME /kafka

# Copy scripts to connect to Zookeeper
COPY healthcheck /
COPY kafka-startup.sh /
COPY entrypoint.sh /

EXPOSE 9092

WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "./kafka-startup.sh" ]
