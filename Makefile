# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lpeeters <lpeeters@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/18 20:28:30 by lpeeters          #+#    #+#              #
#    Updated: 2025/02/26 01:55:02 by lpeeters         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Silence error output
silent = 2> /dev/null

# Build and launch the Docker stack
up:
	@docker-compose -f ./config/docker-compose.yml up --build -d

# Stop the Docker stack
down:
	@docker-compose -f ./config/docker-compose.yml down

# Check Docker stack status
status:
	@docker ps -a

# Display logs for various services
logs:
	@echo "MariaDB:\n"; \
	 docker logs mariadb && \
	 echo "\n\nWordPress:\n"; \
	 docker logs wordpress && \
	 echo "\n\nNginx:\n"; \
	 docker logs nginx

# Shell into the Nginx Docker container
nginx:
	@docker exec -it nginx sh

# Shell into the WordPress Docker container
wordpress:
	@docker exec -it wordpress sh

# Shell into the MariaDB Docker container
mariadb:
	@docker exec -it mariadb sh

# Remove all Docker containers, images, volumes and networks
clean:
	@docker stop $$(docker ps -qa) $(silent); \
	 docker rm $$(docker ps -qa) $(silent); \
	 docker rmi -f $$(docker images -qa) $(silent); \
	 docker volume rm $$(docker volume ls -q) $(silent); \
	 docker network rm $$(docker network ls -q) $(silent) || true

# Restart the Docker stack
re: down up

# Targets
.PHONY: up down status nginx wordpress mariadb logs clean re
