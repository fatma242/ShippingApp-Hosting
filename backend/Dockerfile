# Use a lightweight Node.js base image
FROM node:18-alpine

# Create a non-root user to run the app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Set the ownership and permissions for the app directory
RUN chown -R appuser:appgroup /app && chmod -R 755 /app

# Switch to the non-root user
USER appuser

# Expose the port your application runs on
EXPOSE 5000

# Define the command to run your application
CMD ["npm", "start"]

