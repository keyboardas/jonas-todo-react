# Stage 1: Build the React app
FROM node:alpine as build

WORKDIR /app

COPY package.json .

RUN npm install --silent

COPY . .

RUN npm run build

# Stage 2: Serve the React app using Nginx
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
