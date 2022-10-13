
FROM ubuntu:bionic

RUN DEBIAN_FRONTEND=noninteractive && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime  
RUN apt update && apt-get install -y tzdata && dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install nginx curl python3-pip -y && \
  pip3 install --no-cache-dir --upgrade pip && \
  apt-get clean && \
  apt-get autoclean && \
  rm -rf /var/cache/* && \
  rm -rf /tmp/* && \
  rm -rf /var/tmp/* && \
  rm -rf /var/lib/apt/lists/* && \
  cd /usr/bin && \
  ln -s python3 python && \
  ln -s python3-config python-config && \
  cd /

COPY ./conf.d/default.conf /etc/nginx/nginx.conf

RUN mkdir /app && mkdir -p /var/www/static/

COPY ./dash /app

RUN mv ./app/css /var/www/static/ && chmod +x /app/run.sh && mkdir /dns && mv ./app/img /var/www/static
COPY ./.flag.txt /var/www/

COPY ./bin/geodns geodns

RUN pip3 install -r /app/requirements.txt

EXPOSE 80

EXPOSE 53

EXPOSE 53/udp

WORKDIR /app/

CMD [ "/app/run.sh" ]
