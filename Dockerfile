FROM nginx
COPY index.html /usr/share/nginx/html
COPY site.template /etc/nginx/conf.d/site.template
CMD /bin/sh -c "envsubst < /etc/nginx/conf.d/site.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"