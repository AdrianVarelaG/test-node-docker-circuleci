#!/bin/bash
#docker build -t kster/sample-node .
docker push kster/sample-node:staging

ssh deploy@104.197.98.94 << EOF
docker pull kster/sample-node:staging
docker stop web || true
docker rm web || true
docker rmi kster/sample-node:current || true
docker tag kster/sample-node:latest kster/sample-node:staging
docker run -d --net app --restart always --name web -p 3000:3000 kster/sample-node:current
EOF
