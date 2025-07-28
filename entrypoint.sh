#!/bin/bash
# This script ensures the warp-svc is running before trying to issue commands.
set -e

# Start the warp service in the background
warp-svc &

# Give the service a moment to initialize
sleep 3

# Check if the client is already registered by looking for the registration file.
# This check is important so you don't see the message on every restart.
if [ ! -f "/var/lib/cloudflare-warp/reg.json" ]; then
  echo "----------------------------------------------------------------"
  echo ">>> WARP NOT REGISTERED <<<"
  echo "This is the first time you are running this container."
  echo "You must register the client by running the following command"
  echo "in another terminal:"
  echo ""
  echo "  docker exec -it <container_name_or_id> warp-cli register"
  echo ""
  echo "The container will continue to run, waiting for registration."
  echo "----------------------------------------------------------------"
fi

# You can change the mode here if you prefer something else
warp-cli set-mode warp

# Attempt to connect
warp-cli connect

# Bring the background warp-svc process to the foreground. This makes it
# the main process of the container, keeping it running.
wait
