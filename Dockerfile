FROM debian:bookworm-slim

# Add metadata labels to the image
LABEL maintainer="woody@f2s.com"
LABEL description="A containerised Cloudflare Warp client."

# Install Cloudflare WARP using the official repository method
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    # Add Cloudflare GPG key
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg && \
    # Add Cloudflare repository
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bookworm main" > /etc/apt/sources.list.d/cloudflare-client.list && \
    # Update package list and install WARP
    apt-get update && \
    apt-get install -y cloudflare-warp && \
    # Clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint to our script. This will run every time the container starts.
ENTRYPOINT ["/entrypoint.sh"]

## 
# docker build -t cloudflare-warp . 
# docker run -d --name warp-client --cap-add=NET_ADMIN --cap-add=SYS_ADMIN -v warp-config:/var/lib/cloudflare-warp cloudflare-warp