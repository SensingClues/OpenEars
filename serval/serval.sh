#!/bin/bash
export CAPTUREPARAMS=" "
source serval.env
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
workon serval
cd ../devicehive-dev/
python capture.py $CAPTUREPARAMS 2>&1|awk -v mqttsid=$MQTTSID -F ":" -W interactive '$1 ~ /serval/ {printf("{\"sid\":\"%s\", \"timestamp\":\"%s\", \"class\":\"%s\", \"match\":\"%s\"}\r\n",mqttsid,$2,$3,$4)}'|mosquitto_pub -h $MQTTBROKER -p $MQTTPORT -l -t $MQTTTOPIC -d
