FROM node:18.9.1-alpine

ARG NPM_TOKEN

WORKDIR /usr/src/app
COPY /deployment/.npmrc .npmrc
COPY package.json ./
RUN yarn install
RUN rm -f .npmrc

EXPOSE 3000

CMD ["yarn", "dev"]