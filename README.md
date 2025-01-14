# Usage

1. Clone repository
2. Build image: e.g. `docker build -t github-actions-runner:latest .`, optionally with docker group id: `--build-arg DOCKER_GID=116`
3. (optional - env variables may also be provided manually during run): Create a `.env` file and specify environment variables to use (see below)
4. Run container (if the runner should be able to run docker-in-docker: mount docker.sock): `docker run -d --privileged --env REGISTRATION_TOKEN=XXXXXXXXXX --env-file ./.env -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/lib:/var/lib/docker --rm --name github-actions-runner  github-actions-runner:latest`

## Build args
- `DOCKER_GID`(default: 116)

## Environment variables
- ´REPOSITORY`e.g. seibert-io/github-runner-dockerfile
- `ACCESS_TOKEN` to dynamically retrieve `REGISTRATION_TOKEN`(requires repository admin privileges)
- `REGISTRATION_TOKEN` static token (obtained from repository settings; will expire)
- `LABELS` comma-separated list of labels to assign to the worker

  
