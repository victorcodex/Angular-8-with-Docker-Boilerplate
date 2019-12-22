FROM node:11.15.0-alpine as builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.16.0-alpine as production
COPY --from=builder /app/dist/dockerangular /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
