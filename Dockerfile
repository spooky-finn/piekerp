FROM node:16-alpine 

COPY . /app/
WORKDIR /app/client
RUN yarn install --frozen-lockfile
RUN yarn run build
WORKDIR /app/server
RUN yarn install --frozen-lockfile
RUN yarn run build
# Copy a file with enviroments for an express server and a postgress backup service
COPY .env .
CMD node /app/server/dist/index.js
