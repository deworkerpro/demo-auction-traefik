deploy:
	DOCKER_HOST=ssh://deploy@${HOST}:${PORT} docker network create --driver=overlay traefik-public || true
	DOCKER_HOST=ssh://deploy@${HOST}:${PORT} docker stack deploy --compose-file compose-production.yml traefik --prune
