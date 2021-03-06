# Laravel + MySQL Dev Environment

Run `docker-compose up` and go to [localhost:8000](http://localhost:8000)

## Usage

| Command                                   | Description
| ---                                       | ---
| `docker-compose up`                       | Start [artisan](https://laravel.com/docs/8.x/artisan) dev server and mysql containers
| `docker-compose exec app sh`              | Interactive app container shell
| `docker-compose exec db mysql`            | Interactive mysql shell
| `docker-compose run app composer install` | Install [composer](https://getcomposer.org/doc/00-intro.md) libraries

## Configure User

Run `id` in your shell. Make sure your `uid` and `gid` match the build args in `docker-compose.yml` so that the docker file system permissions match the host user.

If you change these settings run `docker-compose build` after.


## New Project

*Run `docker-compose up --no-start` if you haven't brought the app container up yet*

Copy the default project files from the `app` container in to a new directory

`docker cp laravel-mysql-docker-compose_app_1:/app ../my-app`

## Mount Project

```bash
docker-compose build
ln -s $(realpath docker-compose.yml) ../my-app/
cp override.yml ../my-app/docker-compose.override.yml
cd ../my-app
docker-compose up
```

You can set project specific [configuration](https://docs.docker.com/compose/compose-file/compose-file-v3/) in `docker-compose.override.yml`

## Initialize Database

Put your SQL CREATE / INSERT commands into an .sql file(s) and mount it in the db container under `/docker-entrypoint-initdb.d/` in `docker-compose.override.yml`:

Run `docker-compose rm db` to clear the database volume and re-initialize it with schema changes.

**Example**

```yml
  db:
    volumes:
      - ./init_db.sql:/docker-entrypoint-initdb.d/init_db.sql
```
