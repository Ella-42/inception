# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lpeeters <lpeeters@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/18 20:28:30 by lpeeters          #+#    #+#              #
#    Updated: 2025/01/17 19:26:11 by lpeeters         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

up:
	@docker-compose up --build -d

down:
	@docker-compose down

status:
	@docker ps -a

logs:
	@docker logs webserver

re: down up

.PHONY: up down status logs re
