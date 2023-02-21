FROM node:latest
EXPOSE 3000
WORKDIR /app
ADD file.tar.gz /app/

RUN apt-get update &&\
    apt-get install -y iproute2 systemctl &&\
    curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg &&\
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bullseye main" | tee /etc/apt/sources.list.d/cloudflare-client.list &&\
    apt-get update &&\
    apt-get install -y cloudflare-warp &&\
    systemctl start warp-svc &&\
    warp-cli --accept-tos register &&\
    warp-cli --accept-tos set-mode proxy &&\
    warp-cli --accept-tos connect &&\
    warp-cli --accept-tos enable-always-on &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb &&\
    chmod +x web.js

ENTRYPOINT [ "node", "server.js" ]