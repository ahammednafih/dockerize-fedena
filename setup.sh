#!/bin/bash
github_path="https://raw.githubusercontent.com/ahammednafih/dockerize-fedena/main"
docker_files=( ".gitignore"
"database.yml.docker"
"docker-compose.yml"
"Dockerfile"
"Dockerfile.mariadb"
"entrypoint.sh"
"init.sql" )

for docker_file in "${docker_files[@]}" ; do
  echo "Downloading $docker_file ..."
  curl -O $github_path/$docker_file
done

