#!/bin/zsh

function rcon {
    /root/tools/mcrcon/mcrcon -H localhost -P 25575 -p "3ba51583797b8453a5f3e560" "$1"
}

function backup {
    rcon "save-off"
    rcon "save-all"
    zip -r /root/backups/world-timed-backup-$(date +%Y-%m-%d_%H-%M-%S).zip /root/server/world
    rcon "save-on"
}

function prune {
    find /root/backups -type f -mtime +7 -delete
}

backup
prune