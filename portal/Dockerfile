FROM node:18.9.1-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN yarn install

EXPOSE 3000

CMD ["yarn", "dev"]