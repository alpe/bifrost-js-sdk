FROM alpine:3.7
RUN apk add --update nginx && rm -rf /var/cache/apk/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /web /rw-volume

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./dist/bifrost.min.js /web/assets/bifrost.min.js
COPY ./index.html /web/index.html

RUN chown -R nginx:nginx /web /rw-volume

VOLUME ["/rw-volume"]

EXPOSE 8080
USER "nginx"

CMD ["nginx", "-g", "daemon off;"]