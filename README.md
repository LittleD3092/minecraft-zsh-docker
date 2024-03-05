# 1. About The Project

This project is a dockerfile that setups a container with a minecraft server. The server currently runs on version `1.20.2` and contains mods.

> See `server/mods` for the mods that are installed.

> See `server/forge-x.x.x-x.x.x-installer.jar` for the exact version of the server, in case `README.md` is not updated.

# 2. Getting Started

## Prerequisites

Please install docker on your computer.

## Running the server

To run the server, simply go to the root of the project and run the following command:

```bash
make
```

> The `makefile` contains backup commands and port forwarding commands. Do not run the `docker` command directly.

> You may encounter permission issues when running the `make` command. If so, run the command with `sudo`.

This will build the docker image and open the interactive terminal. From there, you can start the server by running:

```bash
cd /root && ./start-vanilla-server.sh
```

In case you need to attach another terminal to the container, you can run:

```bash
make attach
```

When you exit the container, the `makefile` will copy the world and timed backups to the `backup` folder.

# 3. Structure of the project

- `backup`: Contains the backups of the world. The backups can be timed or upon exit of the container. Either way, the backups only copied to the host when the container is exited.
- `cachefile`: Contains some cache files that are supposed to copy to `/root/.cache` in the container. This is to avoid downloading any files when startup the container.
- `dotfiles`: Contains some dotfiles that are supposed to copy to `/root` in the container. The files are mainly `zshrc` configurations.
- `scripts`: Contains scripts that are essential for the server to run.
  - `start-server.sh`: Starts the server.
  - `backup.sh`: Backups the world. This is called every day at 00:00.
- `server`: Contains the server files. The contents are basic minecraft server files.
  - `world`: The folder that contains the world files.
- `Dockerfile`: The dockerfile that setups the container.
- `Makefile`: The makefile that contains the commands to build and run the container. This also contains backup commands and port forwarding commands.