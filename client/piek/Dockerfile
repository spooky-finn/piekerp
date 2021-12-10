# DEVELOPMENT DOCKERFILE
FROM node:16-alpine3.11

WORKDIR /app/client

COPY package.json /app/client
COPY package-lock.json /app/client

RUN npm install

COPY . /app/client

CMD ["npm", "start"]
