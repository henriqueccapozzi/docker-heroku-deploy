# Sample example to Deploy a docker container to heroku
This repo helps setting up a very simple docker application on heroku

## Deploy Steps

- [Create](https://signup.heroku.com/) a heroku account or [Login](https://id.heroku.com/login) to your existing one
- Download and install the [Heroku cli](https://devcenter.heroku.com/articles/heroku-cli)
- Start a new shell and do the following preparation

```bash
mkdir ~/heroku-docker-deploy
cd ~/heroku-docker-deploy
git init
# if you don't choose a name heroku will generate a random one
APP_NAME="docker-$RANDOM"
heroku apps:create $APP_NAME
heroku git:remote -a $APP_NAME
heroku stack:set container
```
- Make sure you have all the files bellow, you can make any changes to better suit your needs
- Commit the changes locally and push the changes to heroku
```bash
git add .
git commit -m 'My heroku docker deploy'
git push heroku
```


## Files needed
### heroku.yml
Resposible for telling heroku what to build and how
[more info](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#heroku-yml-overview)
```yml
build:
  docker:
    web: Dockerfile
```

### index.html
```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Containers rock</title>
</head>

<body>
    <h1>Hello heroku, i'm a container</h1>
</body>

</html>
```

### site.template
NGINX config file  
The server should listem on the value of the $PORT variable which is set automatically by heroku.
```nginx
server {
    listen       ${PORT};
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
```

### Dockerfile
Building and running instructions
```Dockerfile
FROM nginx
COPY index.html /usr/share/nginx/html
COPY site.template /etc/nginx/conf.d/site.template
CMD /bin/sh -c "envsubst < /etc/nginx/conf.d/site.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"
```


***
# Exemplo de deploy de container no heroku.   
