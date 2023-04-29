# Development environment
FROM node:18.9.1-alpine as development

WORKDIR /usr/src/app

COPY package.json ./

RUN yarn install

EXPOSE 3000

CMD ["yarn", "dev"]

# Build stage environment
FROM node:18.9.1-alpine as build

WORKDIR /usr/src/app

COPY package.json ./

RUN yarn install

COPY . .

EXPOSE 3000

RUN yarn build

# Production environment
FROM node:18.9.1-alpine as production

WORKDIR /usr/src/app

COPY package.json ./

RUN yarn install --production

COPY --from=build /usr/src/app/.next  ./.next

EXPOSE 3000

CMD ["yarn", "start"]