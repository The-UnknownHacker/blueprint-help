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

# Create directory for data persistence
RUN mkdir -p /app/data

# Expose port (if needed for health checks or webhooks)
EXPOSE 3000

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs
RUN adduser -S slackbot -u 1001
USER slackbot

# Start the application
CMD ["npm", "start"]
