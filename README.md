# docker-postgresql

This is the relational model development stack using PostgreSQL. [aka How to] Enterprise Data Modelling development with PostgreSQL, using Docker, from local development up to deliverable to the production deployment end. It uses the [official PostgreSQL docker image](https://github.com/docker-library/postgres) that can be found from [hub](https://hub.docker.com/_/postgres/) or [store](https://store.docker.com/images/postgres).

This does:

- create the DB user that defined in `development.yaml` and `create_user.sh`
- create multiple databases that defined in `development.yaml` and `create_db.sh`
- set the necessary DB users and password defined in `development.yaml` and `.env`
- create necessary PostgreSQL extensions defined in `create_extensions.sh`

It assumes:

- you have docker installed, up and running
- trivially on macOS `brew install docker` or get official [download for Desktop](https://www.docker.com/docker-mac)
- then prepare the environment variables

```
cp env.sample .env
```

### Running Background (aka Daemon)

```
docker-compose -f docker-compose.yaml -f development.yaml --project-name=dev build
docker-compose -f docker-compose.yaml -f development.yaml --project-name=dev up -d
```

- Enter

```
docker ps
docker exec -it dev_postgres_1 bash
```

- Stop

```
docker ps
docker-compose -f docker-compose.yaml -f development.yaml --project-name=dev down
```

- Recycle

```
docker rm dev_postgres_1
docker rmi dev_postgres
```

### Running Foreground (Interactive)

- Change `.cmd` to `.sh` if macOS or Linux.

PS1
```
PS D:\Projects\github\docker-postgresql> .\bin\build.cmd
PS D:\Projects\github\docker-postgresql> .\bin\start.cmd
```

PS2
```
PS D:\Projects\github\docker-postgresql> .\bin\enter.cmd
su - postgres
psql
\l
\c db_api
SELECT * FROM pg_extension;
\q
exit
exit
```

*PS denotes - PowerShell windows*

### Data Modeling

- Use favourite choice of DB Data Modeling tools
    
    - [pgAdmin](https://www.pgadmin.org/)
    - [DataGrip](https://www.jetbrains.com/datagrip/)
    - [SQLDeveloper](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html)
    - [pgModeler](https://github.com/pgmodeler/pgmodeler)
    
- Connect 

    ```
    Host: localhost
    Port: 5432
    Database: db_api
    Username: db_user
    Password: changeme
    ```

- Try sample data modelling in [/model](model)


### Production

- Expand and adapt this to prepare the necessary arrangement for your production environment.

- Check the [docker compose volumes](https://docs.docker.com/compose/compose-file/#volumes) setting to persist the PostgreSQL data - which is commented out in [docker-compose.yaml](docker-compose.yaml)

    ```
        volumes:
          - /mnt/postgresql/data:/var/lib/postgresql/data
    ```