# Setup and build the client

FROM node:13.12.0-alpine as client

# Build args
ARG CORS_CLIENT_URL
ARG REACT_APP_API_URL
ARG REACT_APP_HASURA_WS

# Environment vars
ENV CORS_CLIENT_URL=$CORS_CLIENT_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL
ENV REACT_APP_HASURA_WS=$REACT_APP_HASURA_WS

WORKDIR /app/client/
COPY client/piek/package*.json ./
RUN npm install 
COPY client/piek ./

#recomended build on local machine
# RUN npm run build


# Setup the server

FROM node:13.12.0-alpine

WORKDIR /app/
COPY --from=client /app/client/build/ ./client/build/

WORKDIR /app/server/
COPY server/package*.json ./

RUN npm install 
COPY server/ ./

ENV PORT 9000

EXPOSE 9000

CMD ["npm", "start"]