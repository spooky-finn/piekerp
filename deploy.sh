#!/bin/bash

# build container
docker build -t piekerp:latest --platform linux/amd64 . 
docker save piekerp:latest | gzip > piekerp.tar.gz

# copy to server using rsync
rsync -avzu --progress --human-readable piekerp.tar.gz \
  piek:~/erp/piekerp.tar.gz

# Remote host details
remote_host="piek"
remote_commands=$(cat <<EOF
  gunzip -f ~/erp/piekerp.tar.gz
  docker load -i ~/erp/piekerp.tar
  docker stop erp
  docker rm erp
  docker run -d \
    --env-file ~/erp/.env \
    -p 9000:9000 \
    --name erp \
    --restart always \
    piekerp:latest 
EOF
)

# Function to add a prefix to each line
add_prefix() {
  while IFS= read -r line; do
    echo "[Remote] $line"
  done
}

# Execute remote commands and capture output with prefix
ssh "$remote_host" "$remote_commands" | add_prefix