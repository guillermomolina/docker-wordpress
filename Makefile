build:
	docker image build . -t wordpress:latest

remove:
	docker image remove -f wordpress:latest

deploy:
	docker run -p 8080:80 wordpress:latest
