all: build run clean
build:
	docker build -t minecraft-custom:latest .
run:
	-docker run -it --name minecraft-custom -p 25565:25565 minecraft-custom:latest zsh
#   generate backup folder if not exists
	mkdir -p backup
#   backup upon exit
	zip -r backup/world-exit-backup-$(shell date +%Y-%m-%d_%H-%M-%S).zip server/world
	rm -rf server/world
	docker cp minecraft-custom:/root/server/world server/world
#   copy timed backup
	docker cp minecraft-custom:/root/backups/. backup
clean:
	-docker stop minecraft-custom
	-docker rm minecraft-custom
	docker rmi minecraft-custom:latest
	find backup -type f -mtime +7 -exec rm -f {} \;

attach:
	docker exec -it minecraft-custom /bin/zsh