# Dockerize Fedena

> This is a template to dockerize Fedena ERP.

### Steps

- Clone the setup file

> Run this in root directory of the project.

```shell
curl -O https://raw.githubusercontent.com/ahammednafih/dockerize-fedena/main/setup.sh
```

- Make setup file executable

```shell
chmod +x setup.sh
```

- Get all required files

```shell
./setup.sh
```

> If permission issue -> run as `sudo`

- Run container:

```shell
docker-compose up -d
```

> `-d` will run the containers in the background

- Check container status:

```shell
docker-compose ps
```

> `docker-compose ps -a` will list status of containers that exited with error

- Run multischool:

```shell
docker-compose exec web rake fedena:install_multischool RAILS_ENV=production
```

- Run seeds:

```shell
docker-compose exec web rake fedena:seed_schools RAILS_ENV=production
```

- Check container logs:

```shell
docker-compose logs
```

- Stop container:

```shell
docker-compose down
```

- Rails console:

```shell
docker-compose exec web script/console production
```

- Delete all containers:

```shell
docker rm -f $(docker ps -a -q)
```

> In almost all cases `docker-compose down` removes the containers. Use the above command to cross-verify.

- Delete all volumes:

```shell
docker volume rm $(docker volume ls -q)
```
#
### Fconnect

- Using docker-compose
```shell
docker compose up
```

- Standalone

Start the mariadb container, then build the fconnect image
```shell
docker build -t fconnect .
```
Run the container with link to mariadb
```shell
docker run -p3001:3001 --link <mariadb_image_name>:mariadb fconnect
```
