# Base image for the build stage:
FROM node:16-alpine as build

# Set the working directory for the app:
WORKDIR /app

# Copy the package.json and install dependencies:
COPY package.json .
RUN npm install

# Copy the rest of the application:
COPY . .

# Build the React app:
RUN npm run build

# Base image for the production stage (Nginx):
FROM nginx:alpine

# Set the working directory for Nginx:
WORKDIR /usr/share/nginx/html/

# Copy the build files from the build stage:
COPY --from=build /app/build .

# Expose port 80 for the container:
EXPOSE 80

# Run Nginx to serve the app:
CMD ["nginx", "-g", "daemon off;"]

