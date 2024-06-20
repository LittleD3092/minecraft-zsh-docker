#!/bin/zsh

# Navigate to the server directory
cd ~/server

# Find the Minecraft server JAR file
SERVER_JAR=$(ls minecraft_server.*.jar | head -n 1)

# Run the Minecraft server
java -Xmx2048M -Xms2048M -jar $SERVER_JAR nogui
