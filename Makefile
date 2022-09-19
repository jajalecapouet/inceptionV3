all : build run

build :
	sudo docker-compose -f ./srcs/docker-compose.yml build

run :
	sudo docker-compose -f ./srcs/docker-compose.yml up -d

re :
	sudo docker-compose -f ./srcs/docker-compose.yml up -d --build

clean :
	sudo docker rmi -f $(docker images -qa); echo y | docker builder prune -a

fclean : clean down

down :
	sudo docker-compose -f ./srcs/docker-compose.yml down

prune : down
	echo y | sudo docker system prune -a
