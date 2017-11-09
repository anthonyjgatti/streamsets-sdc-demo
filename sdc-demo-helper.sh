#!/bin/bash

# Bash script to help with sdc demo, calling various docker commands.

# Check arguments.
if [[ $# -ne 1 ]]; then
  echo "Usage: sdc-demo-helper {start, stop, sdc, mysql, cdh, mongo}."
  exit 1
fi

# Spin up services.
if [[ $1 == "start" ]]; then

  # -d runs compose in background, --build watches changes to Dockerfiles.
  docker-compose up -d --build

# Exec into sdc container, make some pipelines.
elif [[ $1 == "sdc" ]]; then
  docker exec -it --user sdc sdc_demo /bin/bash

# Exec into mysql container.
elif [[ $1 == "mysql" ]]; then
  docker exec -it mysql_sdc_demo /bin/bash

# Shut down services.
elif [[ $1 == "stop" ]]; then
  docker-compose down --remove-orphans

# Error if bad entry.
else
  echo "Usage: sdc_demo_helper {start, stop, dc, mysql, cdh, mongo}."
  exit 1
fi
