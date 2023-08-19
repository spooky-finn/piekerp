FROM node:16-alpine as frontend_deps
COPY ./client/package.json /app/client/package.json
COPY ./client/yarn.lock /app/client/yarn.lock
WORKDIR /app/client
RUN yarn install --frozen-lockfile

FROM frontend_deps as frontend
ENV NODE_ENV=production
COPY ./client /app/client
RUN yarn run build


FROM node:16-alpine as backend_deps
COPY ./server/package.json /app/server/package.json
COPY ./server/yarn.lock /app/server/yarn.lock
WORKDIR /app/server
RUN yarn install --frozen-lockfile

FROM backend_deps as backend
ENV NODE_ENV=production
COPY ./server /app/server
RUN yarn run build

FROM node:16-alpine as production
ENV NODE_ENV=production
WORKDIR /app
COPY --from=frontend /app/client/build /app/client/build
COPY --from=backend /app/server/dist /app/server/dist

CMD node /app/server/dist/index.js
