FROM node
WORKDIR /usr/src/app

COPY . .
RUN npm install

ENV NODEJS_API_PORT=8000

CMD ["node", "server.js"]
