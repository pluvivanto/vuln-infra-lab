#!/usr/bin/env bash
set -euxo pipefail

docker stop juice-shop || true
docker rm juice-shop || true

docker pull bkimminich/juice-shop
docker run -d --name juice-shop -p 80:3000 bkimminich/juice-shop