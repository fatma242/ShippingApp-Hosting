# Use a lightweight Node.js base image for building the Angular app
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Install the Angular CLI globally
RUN npm install -g @angular/cli

# Create the Angular cache directory and set permissions
RUN mkdir -p /app/.angular/cache && \
    chown -R node:node /app/.angular/cache && \
    chmod -R 777 /app/.angular/cache

# Set environment variable to redirect Angular cache
ENV NG_CACHE=/app/.angular/cache

# Switch to non-root user
USER node

# Copy the rest of the application code
COPY --chown=node:node . .

# Expose port 4200 for the web server
EXPOSE 4200

# Run the Angular app using 'ng serve'
CMD ["ng", "serve", "--host", "0.0.0.0"]
