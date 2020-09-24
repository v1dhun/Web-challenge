#!/bin/bash
/etc/init.d/nginx start
gunicorn app:app -b 127.0.0.1:3000 -D
/geodns -config /dns/