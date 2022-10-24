FROM node:18.9.1-alpine

RUN apk --no-cache add curl

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

CMD ["npm", "run", "start:debug"]