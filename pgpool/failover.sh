#!/bin/bash
# node 0 is primary, and 1 is standby

new_primary=$1
falling_node=$2

# Do nothing if standby goes down.
if [ $falling_node = 1 ]; then
        exit
fi

ssh -tt -o StrictHostKeyChecking=no root@$new_primary "psql -U postgres -c \"select pg_promote(true,60)\""

