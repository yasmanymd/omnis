FROM node:18.9.1-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN yarn install

CMD ["yarn", "start:dev"]