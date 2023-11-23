# Usage

1. Clone repository
2. Build image: e.g. `docker build -t github-actions-runner:latest .`, optionally with docker group id: `--build-arg DOCKER_GID=116`
3. (optional - env variables may also be provided manually during run): Create a `.env` file and specify environment variables to use (see below)
4. Run container (if the runner should be able to run docker-in-docker: mount docker.sock):
   - via docker run: `docker run -d --env REGISTRATION_TOKEN=XXXXXXXXXX --env-file ./.env -v /var/run/docker.sock:/var/run/docker.sock --rm --name github-actions-runner  github-actions-runner:latest`
   - via docker swarm `docker service create --name gh-actions-runner --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock --env REGISTRATION_TOKEN=AH5WGLBKDAWITRLPMSWG65LFL55IM --env-file ./.env --constraint "node.role == manager" github-actions-runner:latest`

## Build args
- `DOCKER_GID`(default: 116)

## Environment variables
- ´REPOSITORY`e.g. seibert-io/github-runner-dockerfile
- `ACCESS_TOKEN` to dynamically retrieve `REGISTRATION_TOKEN`(requires repository admin privileges)
- `REGISTRATION_TOKEN` static token (obtained from repository settings; will expire)
- `LABELS` comma-separated list of labels to assign to the worker

  
