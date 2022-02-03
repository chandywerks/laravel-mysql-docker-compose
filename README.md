# Laravel + MySQL Dev Environment

Run `docker-compose up` and go to [localhost:8000](http://localhost:8000)

## Usage

| Command                        | Description
| ------------------------------ | ---
| `docker-compose up`            | Start [artisan](https://laravel.com/docs/8.x/artisan) dev server and mysql containers
| `docker-compose exec app sh`   | Interactive app container shell
| `docker-compose exec db mysql` | Interactive mysql shell


## New Project

*Run `docker-compose create` if you haven't brought the app container up yet*

Copy the default project files from the `app` container in to a new directory

`docker cp laravel-mysql-docker-compose_app_1:/app ../my-app`

## Mount Project

```bash
ln -s $(realpath docker-compose.yml) ../my-app/
cp override.yml ../my-app/docker-compose.override.yml
cd ../my-app
docker-compose up
```

You can set project specific [configuration](https://docs.docker.com/compose/compose-file/compose-file-v3/), such as `app` ports or `db` environment variables, in `docker-compose.override.yml`