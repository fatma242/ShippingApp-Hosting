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

# Copy the rest of the application code
COPY . .

# Remove Angular cache to avoid permission issues
RUN rm -rf /app/.angular/cache

# Set permissions for OpenShift's restricted user
RUN chmod -R 775 /app && chown -R 1001:0 /app

# Expose port 4200 for the web server
EXPOSE 4200

# Use a non-root user for running the app (required by OpenShift)
USER 1001

# Run the Angular app using 'ng serve'
CMD ["ng", "serve", "--host", "0.0.0.0"]
