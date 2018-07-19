#!/bin/bash

# Source: https://docs.oracle.com/cd/E37670_01/E41138/html/section_hxz_zdw_pr.html

ENDSTATE=$3
NAME=$2
TYPE=$1

case $ENDSTATE in
    "BACKUP") # Perform action for transition to BACKUP state
              exit 0
              ;;
    "FAULT")  # Perform action for transition to FAULT state
              exit 0
              ;;
    "MASTER") # Perform action for transition to MASTER state
              exit 0
              ;;
    *)        echo "Unknown state ${ENDSTATE} for VRRP ${TYPE} ${NAME}"
              exit 1
              ;;
esac
