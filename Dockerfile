# Use a lightweight Node.js base image for building the Angular app
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Clear Angular cache to avoid potential issues
RUN rm -rf /app/.angular/cache

# Create and fix permissions for the Angular cache
RUN mkdir -p /app/.angular/cache && chmod -R 777 /app/.angular

# Install the Angular CLI globally
RUN npm install -g @angular/cli

# Copy the rest of the application code
COPY . .

# Expose port 4200 for the Angular app's web server
EXPOSE 4200

# Fix permissions at runtime
CMD ["sh", "-c", "chmod -R 777 /app/.angular && ng serve --host 0.0.0.0"]
