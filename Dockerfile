# Build Phase

FROM node:alpine as builder

WORKDIR '/app'

COPY package*.json ./

#ENV http_proxy="http://stlwbsproxy.corp.amdocs.com:8080"
#ENV https_proxy="http://stlwbsproxy.corp.amdocs.com:8080"

RUN npm install

COPY . .

RUN npm run build

# Run Phase

FROM nginx
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html

