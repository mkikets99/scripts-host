#!/bin/bash
read -p 'Path to magento folder: ' fpath
cd $fpath
mkdir -p magento_data/app/code/Chessio
if ! command -v git &> /dev/null
then
    dnf install git
fi
git clone https://github.com/fnogatz/magento2-matomo.git magento_data/app/code/Chessio/Matomo
echo "Restart"
docker compose exec --workdir /bitnami/magento magento chown -R 1:0 ../magento
docker compose restart magento
#printf "Waiting 60 sec"
#sleep 60
read -p "Waiting for input..."
#until [[ "$(docker logs --tail 1 $(docker ps  --format "{{.Names}}" | grep $(basename $(pwd))) 2>&1 | grep -m 1 "FOREG$
echo -e "\nContinue\nStatic Deploy:"
#docker compose exec --workdir /bitnami/magento magento bin/magento setup:static-content:deploy -f en_US $3
./static-gen.sh
echo "Permission fix:"
docker compose exec --workdir /bitnami/magento magento chown -R 1:0 ../magento
