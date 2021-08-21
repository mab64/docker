# Start local registry
docker run -dit -p 5000:5000 -v registry:/var/lib/registry --name registry registry

# Build images
docker build -t localhost:5000/nginx1:0.1 -t localhost:5000/nginx1:latest -f Dockerfile.nginx .
docker build -t localhost:5000/httpd1:0.1 -t localhost:5000/httpd1:latest -f Dockerfile.httpd .

# Push images to local registry
docker push -a localhost:5000/httpd1
docker push -a localhost:5000/nginx1

# Remove images
docker rmi localhost:5000/httpd1:0.1
docker rmi localhost:5000/httpd1:latest
docker rmi localhost:5000/nginx1:0.1
docker rmi localhost:5000/nginx1:latest

# Run containers
docker-compose up -d


#===========
# # Run containers
# $ docker run -dit -p 8080:8080 --mount type=bind,source=$(pwd)/www,destination=/var/www/html --name httpd localhost:5000/httpd1
# $ docker run -dit -p 8081:8081 --mount type=bind,source=$(pwd)/www,destination=/var/www/html --name nginx localhost:5000/nginx1
# # Stop and delete containers
# $ docker stop httpd && docker rm httpd
# $ docker stop nginx && docker rm nginx

