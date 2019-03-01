#!/bin/bash
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
workon serval
cd /home/pi/DL/devicehive-dev/
python capture.py 2>&1|awk -F ":" -W interactive '$1 ~ /serval/ {printf("{\"sid\":\"serval3\", \"timestamp\":\"%s\", \"class\":\"%s\", \"match\":\"%s\"}\r\n",$2,$3,$4)}'|mosquitto_pub -h 192.168.1.23 -p 30002 -l -t sensors -d
