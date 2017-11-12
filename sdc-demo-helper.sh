#!/bin/bash

if [ "$1" != "preview"] || [ "$1" != "data"] || [ "$1" != "start" ]; then
  echo "Usage: sdc-demo-helper {start,preview,data}"
  exit 1
fi

if [ "$1" == "start" ]; then
  echo "starting"

elif [ "$2" == "xml" ]; then
  python demo.py --usecase xml --type $1


fi
