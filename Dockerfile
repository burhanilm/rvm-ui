FROM node:10

WORKDIR /opt/app

COPY . .

RUN npm install

RUN npm run build

CMD [ "npm start" ]