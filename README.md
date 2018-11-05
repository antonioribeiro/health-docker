# Health Panel for Docker Environment

![default panel](https://github.com/antonioribeiro/health/raw/master/docs/images/panel.png)

## What?

This is a docker installation for the Laravel Health Panel, which can be used to check the health of any application.

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

### start mysql and wait for it to start

```bash
docker-compose up mysql &
```

### start the panel

```bash
docker-compose up health
```

### open in your preferred browser

```bash
open http://localhost:8087/health/panel
```
