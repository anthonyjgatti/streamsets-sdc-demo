#!/bin/bash

# CHECK INPUT


if [ "$1" == "start" ]; then
  echo "starting"

  if [ "$2" == "rebuild" ]; then
    docker-compose up -d --build
  else
    docker-compose up -d
  fi


elif [ "$1" == "stop" ]; then
  docker-compose down

else
  python demo.py --type $1 --usecase $2

fi
