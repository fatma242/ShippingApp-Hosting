# # Use a lightweight Node.js base image for building the Angular app
# FROM node:18-alpine AS build

# # Set the working directory
# WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Build the Angular app for production
# RUN npm run build -- --output-path=dist

# # Use the official NGINX base image
# FROM nginx:stable-alpine

# # Copy the NGINX configuration file
# COPY ./nginx.conf /etc/nginx/nginx.conf

# # Copy the built Angular files from the build stage
# COPY --from=build /app/dist /usr/share/nginx/html

# # Expose port 8080 for the application
# EXPOSE 8080

# # Use non-root user for running NGINX
# USER nginx

# # Start the NGINX server
# CMD ["nginx", "-g", "daemon off;"]

# Stage 1: Build the Angular app using a lightweight Node.js base image
# FROM node:18-alpine AS build

# # Set the working directory
# WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
# COPY package*.json ./

# # Install dependencies
# RUN npm ci --only=production

# # Copy the rest of the application code
# COPY . .

# # Build the Angular app for production
# RUN npm run build -- --output-path=dist

# # Stage 2: Serve the Angular app using the official NGINX base image
# FROM nginx:stable-alpine

# # Copy the NGINX configuration file
# COPY ./nginx.conf /etc/nginx/nginx.conf

# # Copy the built Angular files from the build stage
# COPY --from=build /app/dist /usr/share/nginx/html

# # Expose port 8080 for the application
# EXPOSE 8080

# # Use non-root user for running NGINX
# USER nginx

# # Start the NGINX server
# CMD ["nginx", "-g", "daemon off;"]


FROM node:18 

# Set the working directory
WORKDIR /usr/local/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install 

# Copy the rest of the application code
COPY . .
#comment
RUN chmod -R 777 /usr/local/app

# Expose port 4200
EXPOSE 4200


# Start the Angular application using npx
CMD ["npx", "ng", "serve", "--host", "0.0.0.0"]


