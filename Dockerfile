# build stage
FROM node:12-alpine as build

WORKDIR /app

COPY package.json package-lock.json ./
COPY . ./

# install dependencies
RUN npm ci --silent
RUN npm run build

# release stage
FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html
# override ngin default config
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
