# Cloudflare WARP Docker Container

A containerized Cloudflare WARP client that provides a secure, private, and fast internet connection through Cloudflare's network.

## Features

- 🐳 **Dockerized**: Easy deployment using Docker containers
- 🔒 **Secure**: Uses Cloudflare WARP for encrypted internet traffic
- 🚀 **Fast**: Leverages Cloudflare's global network for improved performance
- 📦 **Lightweight**: Based on Debian bookworm-slim for minimal footprint
- 🔄 **Persistent**: Configuration stored in Docker volume

## Quick Start

### 1. Build the Docker Image

```bash
docker build -t cloudflare-warp .
```

### 2. Run the Container

```bash
docker run -d \
  --name warp-client \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_ADMIN \
  -v warp-config:/var/lib/cloudflare-warp \
  cloudflare-warp
```

### 3. Register the WARP Client

On first run, you need to register the client:

```bash
docker exec -it warp-client warp-cli register
```

## Usage

### Basic Commands

Check connection status:
```bash
docker exec -it warp-client warp-cli status
```

Connect to WARP:
```bash
docker exec -it warp-client warp-cli connect
```

Disconnect from WARP:
```bash
docker exec -it warp-client warp-cli disconnect
```

### Configuration

Set WARP mode (options: warp, doh, warp+doh, proxy):
```bash
docker exec -it warp-client warp-cli set-mode warp
```

View current settings:
```bash
docker exec -it warp-client warp-cli settings
```

## Container Details

### Required Capabilities

- `NET_ADMIN`: Required for network interface manipulation
- `SYS_ADMIN`: Required for mounting and system-level operations

### Volumes

- `/var/lib/cloudflare-warp`: Stores WARP registration and configuration data

### Base Image

- **OS**: Debian bookworm-slim
- **Maintainer**: woody@f2s.com

## How It Works

1. The container starts the `warp-svc` service in the background
2. On first run, it prompts for client registration
3. Once registered, it automatically connects to WARP
4. The service runs continuously, providing encrypted internet access

## Troubleshooting

### Registration Issues

If you see "WARP NOT REGISTERED" message:
1. The container is running but waiting for registration
2. Run the registration command in another terminal
3. The container will automatically proceed once registered

### Connection Problems

Check the WARP service status:
```bash
docker exec -it warp-client warp-cli status
```

View container logs:
```bash
docker logs warp-client
```

### Restart the Container

```bash
docker restart warp-client
```

## Environment Variables

Currently, this container doesn't use environment variables for configuration. All settings are managed through the `warp-cli` command.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the changes
5. Submit a pull request

## License

This project packages the official Cloudflare WARP client in a Docker container. Please refer to Cloudflare's terms of service for the WARP client usage.

## Links

- [Cloudflare WARP Official Documentation](https://developers.cloudflare.com/warp-client/)
- [Docker Hub](https://hub.docker.com/)
- [GitHub Repository](https://github.com/duke748/cloudflare-warp)
