#!/bin/bash
#docker build -t kster/sample-node .
docker push kster/sample-node

ssh deploy@104.154.207.199 << EOF
docker pull kster/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi kster/sample-node:current || true
docker tag kster/sample-node:latest kster/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 kster/sample-node:current
EOF
