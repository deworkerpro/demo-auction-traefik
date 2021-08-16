deploy:
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'docker network create --driver=overlay traefik-public || true'
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'rm -rf traefik_${BUILD_NUMBER} && mkdir traefik_${BUILD_NUMBER}'
	scp -o StrictHostKeyChecking=no -P ${PORT} docker-compose-production.yml deploy@${HOST}:traefik_${BUILD_NUMBER}/docker-compose.yml
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'cd traefik_${BUILD_NUMBER} && docker stack deploy -c docker-compose.yml traefik'

rollback:
	ssh -o StrictHostKeyChecking=no deploy@${HOST} -p ${PORT} 'cd traefik_${BUILD_NUMBER} && docker stack deploy -c docker-compose.yml traefik'

