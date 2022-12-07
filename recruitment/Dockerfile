FROM node:18.9.1-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

CMD ["npm", "run", "start:debug"]