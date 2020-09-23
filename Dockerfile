
FROM ubuntu

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

RUN unlink /etc/nginx/sites-enabled/default

RUN mkdir /app && mkdir -p /var/www/static/

COPY ./dash /app

RUN mv ./app/css /var/www/static/ && chmod +x /app/run.sh

RUN pip3 install -r /app/requirements.txt

EXPOSE 80

WORKDIR /app/

CMD [ "/app/run.sh" ]
