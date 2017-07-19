#!/bin/sh

FILE="nat_pat.rules.v4"

if [ "$#" -ne 4 ]; then
    echo "usage : " $0 "port destination [tcp|udp] [save|exec]"
    exit 1
fi

DEST=$2
PORT=$1
PROT=$3
PREROUTING="-t nat -A PREROUTING -p $PROT --dport $PORT -j DNAT --to $DEST:$PORT"
FORWARD="-A FORWARD -p $PROT --dport $PORT -j ACCEPT"
if [ "$4" != "exec" ]
then
    echo $PREROUTING >> $FILE
    echo $FORWARD >> $FILE
else
    eval "iptables $PREROUTING"
    eval "iptables $FORWARD"
fi
