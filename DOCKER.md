# Docker Deployment Guide

## Quick Start

1. **Copy the environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Edit the `.env` file with your Slack credentials:**
   - `SLACK_BOT_TOKEN`: Your Bot User OAuth Token (starts with `xoxb-`)
   - `SLACK_APP_TOKEN`: Your App-Level Token (starts with `xapp-`)
   - `HELP_CHANNEL`: The channel ID where help requests come from
   - `TICKETS_CHANNEL`: The channel ID where tickets are posted
   - `AI_ENDPOINT`: (Optional) Your AI service endpoint

3. **Build and run the application:**
   ```bash
   docker-compose up -d
   ```

## Docker Commands

### Build and start the bot
```bash
docker-compose up -d
```

### View logs
```bash
docker-compose logs -f slack-bot
```

### Stop the bot
```bash
docker-compose down
```

### Rebuild after changes
```bash
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Check status
```bash
docker-compose ps
```

## Data Persistence

The Docker setup includes volume mounts to persist:
- `data/ticket-data.json`: Ticket state and leaderboard data (automatically created)
- `lib/`: FAQ and details markdown files (read-only)
- `data/`: Application data directory for persistence

The application automatically creates the data directory and initializes an empty ticket data file if it doesn't exist.

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `SLACK_BOT_TOKEN` | Yes | Bot User OAuth Token from Slack API |
| `SLACK_APP_TOKEN` | Yes | App-Level Token from Slack API |
| `HELP_CHANNEL` | Yes | Channel ID for help requests |
| `TICKETS_CHANNEL` | Yes | Channel ID for ticket postings |
| `AI_ENDPOINT` | No | AI service endpoint for responses |
| `SLACK_WORKSPACE_DOMAIN` | No | Your Slack workspace domain |
| `NODE_ENV` | No | Node.js environment (default: production) |

## Troubleshooting

### Check if the container is running:
```bash
docker-compose ps
```

### View detailed logs:
```bash
docker-compose logs slack-bot
```

### Restart the service:
```bash
docker-compose restart slack-bot
```

### Access container shell for debugging:
```bash
docker-compose exec slack-bot sh
```

## Security Notes

- The container runs as a non-root user (`slackbot`) for security
- Sensitive tokens are passed via environment variables
- Log rotation is configured to prevent disk space issues
- Health checks are included to monitor service status