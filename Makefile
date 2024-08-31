# `make`: open the container. If the container exists, open it. If not, build and run it.
# `make clean`: stop and remove the container, and remove the image.
# `make backup`: backup the world data to the host machine.

# CAUTION: The world is stored in the container. If you remove the container, the world data will be lost.

.PHONY: all build run clean start attach backup

SHELL := /bin/sh # Default to Unix shell
UNAME := $(shell uname)

ifeq ($(OS),Windows_NT)
    SHELL := powershell.exe
    .SHELLFLAGS := -NoProfile -Command
endif

all: clean build_run

build_run:
	make build
	make run

build:
	docker build -t minecraft-custom:latest .

run:
	-docker run -it --name minecraft-custom -p 25565:25565 -v ./server:/root/server minecraft-custom:latest
	docker stop minecraft-custom

clean:
	-docker stop minecraft-custom
	-docker rm minecraft-custom
	-docker rmi minecraft-custom:latest

start:
	docker start minecraft-custom

stop:
	docker stop minecraft-custom

attach:
	docker exec -it minecraft-custom /bin/zsh

backup:
	rm -rf backup/server
	mkdir -p backup/
	docker cp minecraft-custom:/root/server/ backup/
