#!/usr/bin/env bash
set -e

CONFIG=/etc/keepalived/keepalived.conf

if grep -q '{{' $CONFIG
then
  sed -i "s|{{ STATE }}|$STATE|g" $CONFIG
  sed -i "s|{{ ROUTER_ID }}|$ROUTER_ID|g" $CONFIG
  sed -i "s|{{ INTERFACE }}|$INTERFACE|g" $CONFIG
  sed -i "s|{{ PRIORITY }}|$PRIORITY|g" $CONFIG
  sed -i "s|{{ PASSWORD }}|$PASSWORD|g" $CONFIG


  if [ -n "$NOTIFY" ]; then
    sed -i "s|{{ NOTIFY }}|notify \"$NOTIFY\"|g" $CONFIG
    chmod +x $NOTIFY
  else
    sed -i "|{{ NOTIFY }}|d" $CONFIG
  fi

  for peer in $UNICAST_PEERS; do
    sed -i "s|{{ UNICAST_PEERS }}|${peer}\n    {{ UNICAST_PEERS }}|g" $CONFIG
  done
  sed -i "|{{ UNICAST_PEERS }}|d" $CONFIG

  for vip in $VIRTUAL_IPS; do
    sed -i "s|{{ VIRTUAL_IPS }}|${vip}\n    {{ VIRTUAL_IPS }}|g" $CONFIG
  done
  sed -i "|{{ VIRTUAL_IPS }}|d" $CONFIG
fi

exec /usr/local/sbin/keepalived -f $CONFIG --dont-fork --log-console ${ARGUMENTS}
