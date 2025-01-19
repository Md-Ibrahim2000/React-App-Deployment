#choosing the base image as the build stage:
FROM node:16-alpine as build 

#choosing working directory for the application:
WORKDIR /app

#copying the package.json file to app directory and installing packages:
COPY package.json .
RUN npm install

#copying the rest of application code to the working directory:
COPY . .

#building the application:
RUN npm run build 

#second stage base image:
FROM nginx:alpine

#setting the working directory for this base image:
WORKDIR /usr/share/nginx/html/

#copying the first stage code to this stage
COPY --from=build /app/build .

#exposing the application:
EXPOSE 80

#Executing the application after creating image:
CMD ["nginx", "-g", "daemon off;"]


