#!/bin/bash

echo 'Run local registry...'
docker run -dit -p 5000:5000 -v registry:/var/lib/registry --name registry registry

echo
echo 'Build images...'
docker build -t localhost:5000/nginx1:0.1 -t localhost:5000/nginx1:latest \
             -f Dockerfile.nginx .
docker build -t localhost:5000/httpd1:0.1 -t localhost:5000/httpd1:latest \
             -f Dockerfile.httpd .

echo
echo 'Push images to registry...'
docker push -a localhost:5000/httpd1
docker push -a localhost:5000/nginx1


# To check local registry is working
echo
echo 'Remove local images...'
docker rmi -f localhost:5000/httpd1:0.1 localhost:5000/httpd1:latest \
              localhost:5000/nginx1:0.1 localhost:5000/nginx1:latest

echo
echo 'Run containers...'
docker-compose up -d


#===========
# # Run containers
# $ docker run -dit -p 8080:8080 --mount type=bind,source=$(pwd)/www,destination=/var/www/html --name httpd localhost:5000/httpd1
# $ docker run -dit -p 8081:8081 --mount type=bind,source=$(pwd)/www,destination=/var/www/html --name nginx localhost:5000/nginx1
# # Stop and delete containers
# $ docker stop httpd && docker rm httpd
# $ docker stop nginx && docker rm nginx

