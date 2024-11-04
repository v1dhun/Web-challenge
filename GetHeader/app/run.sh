#!/bin/bash
/etc/init.d/nginx start
gunicorn app:app --workers=5 --threads=2 --worker-class=gthread -b 127.0.0.1:3000