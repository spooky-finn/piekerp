# Setup and build the client

FROM node:14-alpine as client

WORKDIR /app/client/
COPY client/piek/package*.json ./

RUN npm install npm@7.11.2 -g
RUN npm install 

COPY client/piek ./

#recomended build on local machine
# RUN npm run build



# Setup the server

FROM node:14-alpine

WORKDIR /app/
COPY --from=client /app/client/build/ ./client/build/

WORKDIR /app/server/
COPY server/package*.json ./

RUN npm install npm@7.11.2 -g
RUN npm install 
COPY server/ ./


CMD ["npm", "start"]