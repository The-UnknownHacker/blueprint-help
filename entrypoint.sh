#!/bin/sh

# Ensure data directory exists and has proper permissions
mkdir -p /app/data

# If ticket-data.json doesn't exist, create an empty one
if [ ! -f /app/data/ticket-data.json ]; then
    echo '{"tickets":{},"ticketsByOriginalTs":{},"lbForToday":[]}' > /app/data/ticket-data.json
fi

# Execute the original command
exec "$@"