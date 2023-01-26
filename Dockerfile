FROM node:latest
EXPOSE 3000
WORKDIR /app

ADD file.tar.gz /app/

RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -gr package.json

ENTRYPOINT [ "node", "server.js" ]
