#!/bin/bash
. prepare.sh
mkdir -p magento_data/app/code/Chessio
if ! command -v git &> /dev/null
then
    dnf install git
fi
git clone https://github.com/fnogatz/magento2-matomo.git magento_data/app/code/Chessio/Matomo
docker compose exec --workdir /bitnami/magento magento "chown -R 1:0 ../magento"
projects_cmd magento m-soft-regenerate
