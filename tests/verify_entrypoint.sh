#!/bin/bash

export INTERFACE="eth0"
export STATE="BACKUP"
export ROUTER_ID="41"
export PRIORITY="100"
export UNICAST_PEERS="192.168.2.101 192.168.2.102 192.168.2.103"
export VIRTUAL_IPS="192.168.2.100/24"
export PASSWORD="KeptAliv"
export NOTIFY="/tmp/notify.sh"
touch $NOTIFY

cp "${PWD}/assets/keepalived.conf" /tmp/
export CONFIG="/tmp/keepalived.conf"
export EXPECTED="${PWD}/tests/ka.conf.result"

bash ${PWD}/assets/entrypoint.sh 2> /dev/null || echo "Entrypoint script finished!"
cmp --silent $EXPECTED $CONFIG && echo "Entrypoint replacement verified."
