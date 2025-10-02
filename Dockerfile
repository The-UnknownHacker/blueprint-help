# Use the official Node.js 18 image as base
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the application code
COPY . .

# Copy and set permissions for entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create directory for data persistence and set permissions
RUN mkdir -p /app/data && \
    chown -R 1001:1001 /app/data

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs
RUN adduser -S slackbot -u 1001

# Change ownership of the app directory
RUN chown -R slackbot:nodejs /app

USER slackbot

# Expose port (if needed for health checks or webhooks)
EXPOSE 3000

# Set entrypoint and start command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["npm", "start"]