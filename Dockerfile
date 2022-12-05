FROM node:16-alpine 

COPY ./client/build/ /app/client/build/

COPY ./server/dist/index.js /app/
# Copy a file with enviroments for an express server and a postgress backup service
COPY .env .

CMD node /app/index.js
