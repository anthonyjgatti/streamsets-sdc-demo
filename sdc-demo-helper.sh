#!/bin/bash

if [ "$1" != "start" ] && [ "$1" != "stop" ] && [ "$1" != "preview" ] && [ "$1" != "data" ]; then
  echo "Usage: sdc-demo-helper {start,stop,preview,data} {json,csv}"
  exit 1
fi

if [ "$1" == "start" ]; then
  echo "starting"

  # sudo rm -rf ./data/mysql
  # mkdir ./data/mysql
  docker-compose up -d --build

elif [ "$1" == "stop" ]; then
  docker-compose down -v

elif [ "$1" == "preview" ] && [ "$2" != "mysql" ]; then
  python demo.py --type $1 --usecase $2
  if [ "$2" == "csv" ]; then
    cat ./data/sdc/acme_hardwork_output_0.csv
  fi

elif [ "$1" == "preview" ] && [ "$2" == "mysql" ]; then
  docker exec -it mysql_sdc_demo mysql -u root -p acme
fi
