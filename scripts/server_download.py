VERSION_MANIFEST_URL = "https://launchermeta.mojang.com/mc/game/version_manifest.json"

import json
import requests
import argparse
import urllib.request

rManifest = requests.get(VERSION_MANIFEST_URL)
manifest = rManifest.json()

latestVersion = manifest["latest"]["release"]
latestSnapshotVersion = manifest["latest"]["snapshot"]

a = argparse.ArgumentParser()
a.add_argument("-v", "--version", help="Version, default to latest", default=latestVersion)
a.add_argument("-s", "--snapshot", help="Use the latest snapshot", const=latestSnapshotVersion, dest="version", action="store_const")

args = a.parse_args()
version = args.version

versionURL = None

for v in manifest["versions"]:
	if v["id"] == version:
		versionURL = v["url"]
		break

if versionURL == None:
	print("Can't find version " + version)
else:
	rVersionManifest = requests.get(versionURL)
	versionManifest = rVersionManifest.json()

	serverDownloadURL = versionManifest["downloads"]["server"]["url"]

	print("Downloading server version " + version + "...")

	urllib.request.urlretrieve(serverDownloadURL, f"minecraft_server.{version}.jar")

	print("Done!")