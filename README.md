# Xray + Argo for Container PaaS

为容器平台而生---平台部署方式为镜像或者 Dockerfile 方式的专用

* * *

# 目录

- [项目特点](README.md#项目特点)
- [部署](README.md#部署)
- [在 Koyeb 部署重点](README.md#在-koyeb-部署重点)
- [在 Doprax 部署重点](README.md#在-doprax-部署重点)
- [鸣谢下列作者的文章和项目](README.md#鸣谢下列作者的文章和项目)
- [免责声明](README.md#免责声明)

* * *

## 项目特点:
* 适用于通过 dockerhub 上已有的镜像或 Dockerfile 来建实例的平台
* 在平台上部署 Xray，采用的方案为 Argo + Xray + WebSocket + TLS
* 在浏览器查看系统各项信息，方便直观
* 使用 CloudFlare 的 Argo 隧道，直接优选 + 隧道，CDN 不用再做 workers
* 回流分流，同时支持 Xray 4 种主流协议: vless /  vmess / trojan / shadowsocks
* vmess 和 vless 的 uuid，trojan 和 shadowsocks 的 password，各协议的 ws 路径既可以自定义，又或者使用默认值
* 集成哪吒探针，可以自由选择是否安装
* 前端 js 定时保活，会玩的用户可以根据具体情况修改间隔时间
* 节点信息以 V2rayN / Clash / 小火箭 链接方式输出
* Xray 文件重新编译官方文件增加隐秘性，修改了运行时的显示信息，文件为: https://github.com/XTLS/Xray-core/blob/main/core/core.go

<img width="718" alt="image" src="https://user-images.githubusercontent.com/92626977/215277537-ff358dc1-7696-481f-b8e4-74f0cdff30f4.png">


## 部署:
* 镜像 `fscarmen/argo-x:latest`

* PaaS 平台用到的变量
  | 变量名        | 是否必须 | 默认值 | 备注 |
  | ------------ | ------ | ------ | ------ |
  | UUID         | 否 | de04add9-5c68-8bab-950c-08cd5320df18 | 可在线生成 https://www.zxgj.cn/g/uuid |
  | WSPATH       | 否 | argo | 勿以 / 开头，各协议路径为 `/WSPATH-协议`，如 `/argo-vless`,`/argo-vmess`,`/argo-trojan`,`/argo-shadowsocks` |
  | NEZHA_SERVER | 否 |        | 哪吒探针服务端的 IP 或域名 |
  | NEZHA_PORT   | 否 |        | 哪吒探针服务端的端口 |
  | NEZHA_KEY    | 否 |        | 哪吒探针客户端专用 Key |

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

## 在 Koyeb 部署重点

这里只作重点的展示，更详细可以参考项目: https://github.com/fscarmen2/V2-for-Koyeb

[![Deploy to Koyeb](https://www.koyeb.com/static/images/deploy/button.svg)](https://app.koyeb.com/deploy?type=docker&name=argox&ports=3000;http;/&env[UUID]=de04add9-5c68-8bab-950c-08cd5320df18&env[NEZHA_SERVER]=server%20domain%20or%20ip&env[NEZHA_PORT]=server%20port&env[NEZHA_KEY]=agent%20key&image=docker.io/fscarmen/argo-x)

![image](https://user-images.githubusercontent.com/92626977/214794752-9df27bee-66e7-4d79-855f-940e85dab8c3.png)

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