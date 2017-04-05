#!/bin/bash
#docker build -t kster/sample-node .
docker push kster/sample-node:qa

ssh deploy@35.184.189.76 << EOF
docker pull kster/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi kster/sample-node:qa || true
docker tag kster/sample-node:qa kster/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 kster/sample-node:current
EOF
