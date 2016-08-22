#!/bin/bash

docker build -t arcseldon/my-node-app ./docker-app
docker build -t arcseldon/my-nginx ./docker-nginx
docker run --name my-node-app -p 4567:4567 -d arcseldon/my-node-app
docker run --name nginx-container \
  -v $(pwd)/html:/usr/share/nginx/html:ro \
  -v $(pwd)/docker-nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
  --link my-node-app:app \
  -P -d arcseldon/my-nginx
curl http://localhost:32769/
curl http://localhost:32769/test.html
curl http://localhost:32769/app/