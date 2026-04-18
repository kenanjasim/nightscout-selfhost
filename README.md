# Deploy Nightscout on a local machine with Cloudflare Tunnel

This repository contains the necessary files and configurations to deploy Nightscout and MongoDB through Docker Compose, exposed securely via Cloudflare Tunnel — no open ports, no nginx, no SSL certificates to manage.

## Prerequisites

- Docker and Docker Compose installed on your host machine
- A domain managed by Cloudflare
- `cloudflared` installed on your host machine ([instructions here](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/)) and set up to port 7380

## Setup

### 1. Configure your environment

Copy the example env file and fill in your values:

```bash
cp env.example env
```

Generate a secure `API_SECRET`:

```bash
openssl rand -base64 32
```

See [Nightscout setup variables](https://nightscout.github.io/nightscout/setup_variables/) for a full reference on all available variables.

### 2. Start Nightscout

```bash
docker compose --env-file=env up -d
```

Start the Cloudflare Tunnel:

```bash
cloudflared tunnel run nightscout
```

To run `cloudflared` as a system service so it starts automatically:

```bash
cloudflared service install
```

### 4. Bring it down

```bash
docker compose --env-file=env down
```

## Security

- Cloudflare Tunnel handles SSL termination — no certificates to manage or renew
- No ports are exposed on your router
- Ensure your `API_SECRET` is strong and keep your `env` file out of version control (it is already in `.gitignore`)