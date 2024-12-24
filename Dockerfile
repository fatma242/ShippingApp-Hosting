# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Add non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set ownership and permissions
RUN mkdir -p /app/.angular/cache && \
    chown -R appuser:appgroup /app && \
    chmod -R 777 /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Install Angular CLI
RUN npm install -g @angular/cli

# Copy rest of the application
COPY . .

# Set environment variable for Angular cache
ENV NG_CACHE=/tmp/.angular/cache

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 4200

# Start the application
CMD ["ng", "serve", "--host", "0.0.0.0", "--disable-host-check"]
