# node 0 is primary, and 1 is standby

# If standby goes down, do nothing. If primary goes down, create a
# trigger file so that standby takes over primary node.

new_primary=$1
falling_node=$2

# Do nothing if standby goes down.
if [ $falling_node = 1 ]; then
        exit
fi

# Create the trigger file.
ssh -tt -o StrictHostKeyChecking=no root@$new_primary "psql -U postgres -c \"select pg_promote(true,60)\""

