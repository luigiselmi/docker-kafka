#!/bin/bash

set -e

echo `date` $0

echo $0
if [[ -z "$TOPIC" ]] ;then
    echo $0 : no TOPIC
else
    echo $0 : make topics TOPIC=$TOPIC
    export MAKETOPIC_CMD="/kafka/bin/kafka-topics.sh \
                    --zookeeper $ZOOKEEPER_SERVERS \
                    --create --partitions $TOPIC_PARTITIONS --replication-factor $TOPIC_REPLICAS --topic"
    (
        # await kafka server at localhost
        until nc -z localhost 9092 ;do
            >&2 echo "localhost 9092 is yet unavailable - sleep 1"
            sleep 1
        done
        echo "localhost:9092 is available"

        $MAKETOPIC_CMD "$TOPIC"
        RC=$?
        if [[ $RC == 0 ]] ;then
            touch /TOPIC_AVAILABLE
            echo available: TOPIC=$TOPIC
        else
            echo cannot create TOPIC: $TOPIC
        fi
    ) &
fi

exec /kafka/bin/kafka-server-start.sh /kafka/config/server.properties --override zookeeper.connect=$ZOOKEEPER_SERVERS --override broker.id=$BROKER_ID
