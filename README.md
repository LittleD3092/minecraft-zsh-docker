# 1. About The Project

This project is a dockerfile that setups a container with a minecraft server. The server currently runs on version `1.20.2`, but can be changed by putting the right server jar file (e.g. `minecraft_server.1.x.x.jar`) in the `server` folder.

# 2. Getting Started

## Prerequisites

Please install docker and make on your computer.

## Running the server

To run the server, simply go to the root of the project and run the following command:

```bash
make
```

> The `makefile` contains backup commands and port forwarding commands. Do not run the `docker` command directly.

> You may encounter permission issues when running the `make` command. If so, run the command with `sudo`.

This will build the docker image and open the interactive terminal. The server will run upon startup. If you have a existing container (e.g. you started it with `make` before), `make` will recognize it and start and attach to the existing container.

In case you need to attach another terminal to the container, you can run:

```bash
make attach
```

The backup of the world is implemented in a manual way. To backup the world, run the following command:

```bash
make backup
```

# 3. Structure of the project

- `backup`: Contains the backups of the world. The backups are generated manually by `make backup`, and will replace the old `server` folder. To prevent the `server` folder from being replaced, please rename the `server` folder to something else.
- `cachefile`: Contains some cache files that are supposed to copy to `/root/.cache` in the container. This is to avoid downloading any files when startup the container.
- `dotfiles`: Contains some dotfiles that are supposed to copy to `/root` in the container. The files are mainly `zshrc` configurations.
- `scripts`: Contains scripts that are essential for the server to run.
  - `start-server.sh`: Starts the server.
- `server`: Contains the server files. The contents are basic minecraft server files.
  - `world`: The folder that contains the world files.
- `Dockerfile`: The dockerfile that setups the container.
- `Makefile`: The makefile that contains the commands to build and run the container. This also contains backup commands and port forwarding commands.