#!/bin/zsh

# Navigate to the server directory
cd ~/server

# Find the Minecraft server JAR file
SERVER_JAR=$(ls minecraft_server.*.jar | head -n 1)

# Run the Minecraft server
exec java -Xmx8G -Xms2G -jar $SERVER_JAR nogui
