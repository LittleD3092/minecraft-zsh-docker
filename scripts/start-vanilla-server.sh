#!/bin/zsh

# Navigate to the server directory
cd ~/server

# If the server JAR file does not exist, download it
if ls minecraft_server.*.jar 1> /dev/null 2>&1; then
    SERVER_JAR=$(ls minecraft_server.*.jar | tail -n 1)
else
    python3 ../server_download.py
    SERVER_JAR=$(ls minecraft_server.*.jar | tail -n 1)
fi

# sign eula
echo "eula=true" > eula.txt

# Run the Minecraft server
exec java -Xmx8G -Xms2G -jar $SERVER_JAR nogui
