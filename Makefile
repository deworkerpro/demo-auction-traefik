deploy:
	ssh deploy@${HOST} -p ${PORT} 'docker network create --driver=overlay traefik-public || true'
	ssh deploy@${HOST} -p ${PORT} 'rm -rf traefik_${BUILD_NUMBER} && mkdir traefik_${BUILD_NUMBER}'
	scp -P ${PORT} compose-production.yml deploy@${HOST}:traefik_${BUILD_NUMBER}/compose.yml
	ssh deploy@${HOST} -p ${PORT} 'cd traefik_${BUILD_NUMBER} && docker stack deploy -c compose.yml traefik'

rollback:
	ssh deploy@${HOST} -p ${PORT} 'cd traefik_${BUILD_NUMBER} && docker stack deploy -c compose.yml traefik'

