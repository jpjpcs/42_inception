all: config up

config:
	@if [ ! -d "$$HOME/data/mariadb" ]; then \
	mkdir -p $$HOME/data/mariadb; fi
	@if [ ! -d "$$HOME/data/wordpress" ]; then \
	mkdir -p $$HOME/data/wordpress; fi
	cp -v ~/.env ./srcs/
	#@if [ ! -f "srcs/.env" ]; then \
	#cd srcs && cp -v README.txt -T .env; fi
	# uncomment the line below if /etc/hosts doesn't have it
	# echo "127.0.0.1 jode-jes.42.fr" | sudo tee -a /etc/hosts
    
    
up: config
	cd srcs && docker compose up --build

down:
	cd srcs && docker compose down --volumes

start:
	cd srcs && docker compose start

stop:
	cd srcs && docker compose stop

#clean-images:
#	cd srcs && docker rmi -f $$(docker images -q) || true

clean-images:
	cd srcs && { imgs=$$(docker images -q); [ -n "$$imgs" ] && docker rmi -f $$imgs || echo "No images to remove."; }

clean-env:
	@rm -f ./srcs/.env

clean-data:
	@if [ -d "$$HOME/data/mariadb" ]; then \
		echo "Removing $$HOME/data/mariadb..."; \
		sudo rm -rf $$HOME/data/mariadb; fi
	@if [ -d "$$HOME/data/wordpress" ]; then \
		echo "Removing $$HOME/data/wordpress..."; \
		sudo rm -rf $$HOME/data/wordpress; fi
	@if [ -d "$$HOME/data/" ]; then \
		echo "Removing $$HOME/data/..."; \
		sudo rm -rf $$HOME/data/; fi

clean: down clean-images clean-env

fclean: clean clean-data
	@docker system prune -a

re: fclean config up
