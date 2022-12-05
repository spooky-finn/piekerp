# The complited app directory in the container looks like that:
# -------------------------------------------------------------
# app/
#     clien/
#         build/
#             .....
#     server/
#         app.js
#         controllers/
#         ....
#     .env
# -------------------------------------------------------------

# Setup the server
FROM node:13.12.0-alpine 

WORKDIR /app/
COPY ./client/build/ /app/client/build/

WORKDIR /app/server/
COPY /app/server/package*.json ./

RUN yarn install
COPY server/ ./

# Copy a file with enviroments for an express server and a postgress backup service
COPY .env/ /app/

CMD ["yarn", "start"]
