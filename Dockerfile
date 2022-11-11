FROM node:16 as builder

WORKDIR /frontend

COPY . .

RUN yarn install \
  --prefer-offline \
  --frozen-lockfile \
  --non-interactive \
  --production=false

RUN yarn build

RUN rm -rf node_modules && \
  NODE_ENV=production yarn install \
  --prefer-offline \
  --pure-lockfile \
  --non-interactive \
  --production=true

FROM node:16

WORKDIR /frontend

COPY --from=builder /frontend  .

ENV HOST 0.0.0.0

ENV PORT 3000

EXPOSE ${PORT}

CMD [ "yarn", "start" ]
