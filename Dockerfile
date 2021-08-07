# Setup and build the client

FROM node:16-alpine3.11 as client

WORKDIR /app/client/
COPY client/piek/package*.json ./
RUN npm install -g npm@7.20.5
RUN npm install 
COPY client/piek ./
RUN npm run build


# Setup the server

FROM node:16-alpine3.11

WORKDIR /app/
COPY --from=client /app/client/build/ ./client/build/

WORKDIR /app/server/
COPY server/package*.json ./
RUN npm install -g npm@7.20.5
RUN npm install 
COPY server/ ./

ENV PORT 9000

EXPOSE 9000

CMD ["npm", "start"]