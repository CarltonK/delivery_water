run:
	cd functions/src; nodemon -e ts --exec "npm run serve"
build:
	docker-compose up --build