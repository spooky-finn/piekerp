FROM node:16-alpine as frontend
COPY .client/ /app/client/
WORKDIR /app/client
RUN yarn install --frozen-lockfile
RUN yarn run build

FROM node:16-alpine as backend
COPY .server/ /app/server/
WORKDIR /app/server
RUN yarn install --frozen-lockfile
RUN yarn run build


FROM node:16-alpine as production
ENV NODE_ENV=production
WORKDIR /app
COPY --from=frontend /app/client/build /app/client/build
COPY --from=backend /app/server/dist /app/server/dist

CMD node /app/server/dist/index.js
