all : start build run

start : dir_db dir_wp

dir_db :
	sudo mkdir -p /home/njaros/data/db

dir_wp :
	sudo mkdir -p /home/njaros/data/wp
	
build :
	sudo docker-compose -f ./srcs/docker-compose.yml build

run :
	sudo docker-compose -f ./srcs/docker-compose.yml up -d

re : start
	sudo docker-compose -f ./srcs/docker-compose.yml up -d --build

clean :
	sudo docker rmi -f $(docker images -qa); echo y | docker builder prune -a

fclean : clean down

down :
	sudo docker-compose -f ./srcs/docker-compose.yml down

vclean :
	sudo docker volume rm db wordpress

prune : down vclean
	echo y | sudo docker system prune -a
