# Xray + Argo for Container PaaS

为容器平台而生---平台部署方式为镜像或者 Dockerfile 方式的专用

* * *

# 目录

- [项目特点](README.md#项目特点)
- [部署](README.md#部署)
- [Argo Token的获取](README.md#argo-token-的获取)
- [在 Koyeb 部署重点](README.md#在-koyeb-部署重点)
- [在 Doprax 部署重点](README.md#在-doprax-部署重点)
- [鸣谢下列作者的文章和项目](README.md#鸣谢下列作者的文章和项目)
- [免责声明](README.md#免责声明)

* * *

## 项目特点:
* 适用于通过 dockerhub 上已有的镜像或 Dockerfile 来建实例的平台
* 在平台上部署 Xray，采用的方案为 Argo + Xray + WebSocket + TLS
* 解锁 ChatGPT
* 在浏览器查看系统各项信息，方便直观
* 使用 CloudFlare 的 Argo 隧道，使用TLS加密通信，可以将应用程序流量安全地传输到Cloudflare网络，提高了应用程序的安全性和可靠性。此外，Argo Tunnel也可以防止IP泄露和DDoS攻击等网络威胁。
* 回落分流，同时支持 Xray 4 种主流协议: vless /  vmess / trojan / shadowsocks
* vmess 和 vless 的 uuid，trojan 和 shadowsocks 的 password，各协议的 ws 路径既可以自定义，又或者使用默认值
* 集成哪吒探针，可以自由选择是否安装
* 前端 js 定时和 pm2 配合保活，务求让恢复时间减到最小
* 节点信息以 V2rayN / Clash / 小火箭 链接方式输出
* Xray 文件重新编译官方文件增加隐秘性，修改了运行时的显示信息，文件为: https://github.com/XTLS/Xray-core/blob/main/core/core.go

<img width="718" alt="image" src="https://user-images.githubusercontent.com/92626977/215277537-ff358dc1-7696-481f-b8e4-74f0cdff30f4.png">


## 部署:
### 镜像 `fscarmen/argo-x:latest`

### PaaS 平台用到的变量:
 
* 在 `server.js` 文件的第1、2行修改查询网页的用户名和密码
  | 变量名        | 是否必须 | 默认值 | 备注 |
  | ------------ | ------ | ------ | ------ |
  | WEB_USERNAME | 是 | admin | 网页的用户名 |
  | WEB_PASSWORD | 是 | password | 网页的密码 |

* 在 `entrypoint.sh` 文件的前面 4-12 行修改；访问页面的认证在 `server.js` 文件的第1、2行修改必填
  | 变量名        | 是否必须 | 默认值 | 备注 |
  | ------------ | ------ | ------ | ------ |
  | UUID         | 否 | de04add9-5c68-8bab-950c-08cd5320df18 | 可在线生成 https://www.zxgj.cn/g/uuid |
  | WSPATH       | 否 | argo | 勿以 / 开头，各协议路径为 `/WSPATH-协议`，如 `/argo-vless`,`/argo-vmess`,`/argo-trojan`,`/argo-shadowsocks` |
  | NEZHA_SERVER | 否 |        | 哪吒探针服务端的 IP 或域名，与 NEZHA_ARGO 只能同时存在一个 |
  | NEZHA_ARGO   | 否 |        | 哪吒探针服务端的 argo 隧道域名，与 NEZHA_SERVER 只能同时存在一个 |
  | NEZHA_PORT   | 否 |        | 哪吒探针服务端的端口，如果服务端是 Argo，则不需要填写 |
  | NEZHA_KEY    | 否 |        | 哪吒探针客户端专用 Key |
  | ARGO_AUTH    | 否 |        | Argo 的 Token 或者 json 值 |
  | ARGO_DOMAIN  | 否 |        | Argo 的域名，须与 ARGO_DOMAIN 必需一起填了才能生效 |

* 需要应用的 js
  | 命令 | 说明 |
  | ---- |------ |
  | <URL>/list | 查看节点数据 |
  | <URL>/status | 查看后台进程 |
  | <URL>/listen | 查看后台监听端口 |
  
* GitHub Actions 用到的变量

  | 变量名 | 备注 |
  | --------------- | -------------- |
  | DOCKER_USERNAME | Dockerhub 用户名|
  | DOCKER_PASSWORD | Dockerhub 密码 |
  | DOCKER_REPO     | Dockerhub 库名 |


## Argo Token 的获取

详细教程: [群晖套件：Cloudflare Tunnel 内网穿透中文教程 支持DSM6、7](https://imnks.com/5984.html)

<img width="1409" alt="image" src="https://user-images.githubusercontent.com/92626977/218253461-c079cddd-3f4c-4278-a109-95229f1eb299.png">

<img width="1619" alt="image" src="https://user-images.githubusercontent.com/92626977/218253838-aa73b63d-1e8a-430e-b601-0b88730d03b0.png">

<img width="1155" alt="image" src="https://user-images.githubusercontent.com/92626977/218253971-60f11bbf-9de9-4082-9e46-12cd2aad79a1.png">

## 在 Koyeb 部署重点

这里只作重点的展示，更详细可以参考项目: https://github.com/fscarmen2/V2-for-Koyeb

[![Deploy to Koyeb](https://www.koyeb.com/static/images/deploy/button.svg)](https://app.koyeb.com/deploy?type=docker&name=argox&ports=3000;http;/&env[UUID]=de04add9-5c68-8bab-950c-08cd5320df18&env[NEZHA_SERVER]=server%20domain%20or%20ip&env[NEZHA_PORT]=server%20port&env[NEZHA_KEY]=agent%20key&env[ARGO_AUTH]=argo%20token%20or%20json&env[ARGO_DOMAIN]=Argo%20domain&env[WEB_USERNAME]=Web%20username&env[WEB_PASSWORD]=Web%20password&image=docker.io/fscarmen/argo-x)

<img width="680" alt="image" src="https://user-images.githubusercontent.com/92626977/218254134-20258fd8-f925-4f17-97f6-9a46cc28b364.png">

<img width="909" alt="image" src="https://user-images.githubusercontent.com/92626977/214797317-bc60c51b-9518-4db1-9878-f6c8eb52a9b3.png">

<img width="1340" alt="image" src="https://user-images.githubusercontent.com/92626977/215122040-7f3ba11b-4875-412c-a9c9-fefa05e336c5.png">

## 在 Doprax 部署重点

这里只作重点的展示，更详细可以参考项目: https://github.com/fscarmen2/V2-for-Doprax
  
<img width="1663" alt="image" src="https://user-images.githubusercontent.com/92626977/214801019-a1e9cf5d-67f0-49c5-956b-927f50bbb207.png">

<img width="1000" alt="image" src="https://user-images.githubusercontent.com/92626977/214807633-18b1a1fe-a3b7-4f9b-99bd-0ef56e3a259c.png">

## 鸣谢下列作者的文章和项目:
* 前端 JS 在大佬 Nike Jeff 的项目 基础上，为了通用性和扩展功能作修改，https://github.com/hrzyang/glitch-trojan
* 后端全部原创，如转载须注明来源。

## 免责声明:
* 本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。
* 使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责。
