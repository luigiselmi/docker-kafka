#!/bin/bash

set -e

echo `date` $0

echo $0 
if [[ -z "$INITIAL_TOPICS" ]] ;then
    echo $0 : no INITIAL_TOPICS
else
    echo $0 : make topics INITIAL_TOPICS=$INITIAL_TOPICS
    export MAKETOPIC_CMD="/kafka/bin/kafka-topics.sh \
                    --zookeeper $ZOOKEEPER_SERVERS \
                    --create --partitions 1 --replication-factor 1 --topic"
    (
        # await kafka server at localhost
        until nc -z localhost 9092 ;do
            >&2 echo "localhost 9092 is yet unavailable - sleep 1"
            sleep 1
        done
        echo "localhost:9092 is available"

        $MAKETOPIC_CMD taxi
        RC=$?
        if [[ $RC == 0 ]] ;then
            touch /INITIAL_TOPICS_AVAILABLE
            echo available: INITIAL_TOPICS=$INITIAL_TOPICS
        else
            echo cannot create INITIAL_TOPICS: $INITIAL_TOPICS
        fi
    ) &
fi

exec /kafka/bin/kafka-server-start.sh /kafka/config/server.properties --override zookeeper.connect=$ZOOKEEPER_SERVERS
