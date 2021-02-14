run:
	cd functions/src; nodemon -e ts --exec "npm run serve"
build:
	docker-compose up --build
kill:
	docker-compose down
export:
	firebase emulators:export ./data