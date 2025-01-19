# Base image for the build stage:
FROM node:16-alpine as build

# Set the working directory for the app:
WORKDIR /app

# Copy package files and install dependencies:
COPY package.json package-lock.json ./
RUN npm ci

# Copy the rest of the application source code:
COPY . .

# Build the React app:
RUN npm run build

# Base image for the production stage (Nginx):
FROM nginx:alpine

# Remove default Nginx static assets:
RUN rm -rf /usr/share/nginx/html/*

# Copy the build files from the build stage:
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the container:
EXPOSE 80

# Add custom Nginx configuration for React SPA:
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Run Nginx to serve the app:
CMD ["nginx", "-g", "daemon off;"]

