# App Health Panel for Docker Environment

![default panel](https://github.com/antonioribeiro/health/raw/master/docs/images/panel.png)

## What?

This is a docker installation for the [Laravel Health Panel](https://github.com/antonioribeiro/health), which can be used to check the health of any application.

## Running

### clone

```bash
git clone https://github.com/antonioribeiro/health-docker.git
cd health-docker
```

### build everything

```bash
docker-compose build
```

### configure

Edit the docker-compose.yml and eventually provide a new configuration folder with docker volumes or provide new values for environment variables.

### start the services

```bash
docker-compose up -d
```

### open in your preferred browser

```bash
open http://localhost:8087/health/panel
```
