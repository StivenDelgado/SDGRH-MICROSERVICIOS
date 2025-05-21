NETWORK_NAME=red_microservicios

# Crea la red si no existe
create-network:
	@sudo docker network inspect $(NETWORK_NAME) > /dev/null 2>&1 || \
	sudo docker network create $(NETWORK_NAME)

# Levanta los servicios con docker-compose
up:
	sudo docker-compose up -d --build

# Detiene y elimina contenedores
down:
	sudo docker-compose down

# Elimina la red
remove-network:
	sudo docker network rm $(NETWORK_NAME)


PROJECTS = \
	./backend-user \
	./backend-check-in \
	./backend-payroll \
	./backend-goals \
	./ \

up-all:
	for dir in $(PROJECTS); do \
		echo "Levantando servicio en $$dir..."; \
		(cd $$dir && sudo docker-compose up -d --build); \
	done

down-all:
	for dir in $(PROJECTS); do \
		echo "Apagando servicio en $$dir..."; \
		(cd $$dir && sudo docker-compose down); \
	done
