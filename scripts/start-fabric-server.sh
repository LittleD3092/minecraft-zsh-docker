#!/bin/zsh

# Navigate to the server directory
cd ~/server

# If the server JAR file does not exist, download it
if ls fabric-server-mc.*.jar 1> /dev/null 2>&1; then
    SERVER_JAR=$(ls fabric-server-mc.*.jar | tail -n 1)
else
    curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.21.1/0.16.3/1.0.1/server/jar
    SERVER_JAR=$(ls fabric-server-mc.*.jar | tail -n 1)
fi

# sign eula
echo "eula=true" > eula.txt

# Run the Minecraft server
exec java -Xmx8G -Xms2G -jar $SERVER_JAR nogui
