# Setup and build the client

FROM node:16-buster as client

WORKDIR /app/client/
COPY client/piek/package*.json ./

RUN npm install 
COPY client/piek ./
RUN npm run build


# Setup the server

FROM node:16-buster

WORKDIR /app/
COPY --from=client /app/client/build/ ./client/build/

WORKDIR /app/server/
COPY server/package*.json ./

RUN npm install 
COPY server/ ./

ENV PORT 9000

EXPOSE 9000

CMD ["npm", "start"]