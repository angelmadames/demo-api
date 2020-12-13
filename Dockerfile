FROM node:${NODE_VERSION:-14-alpine} AS install-deps

ENV CI true

COPY package.json .
COPY package-lock.json .

RUN npm install

FROM node:${NODE_VERSION:-14-alpine} AS serve

ENV PORT 3000
ENV NODE_ENV production

WORKDIR /app

COPY --from=install-deps /node_modules node_modules
COPY . ./

EXPOSE 3000

CMD ["node", "app.js"]
