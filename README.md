This is an image for the snapcast server (https://github.com/badaix/snapcast).

Server is compiled with librespot and shairport-sync support. when running the image 

Run:
docker run -d \
    --name snapserver \
    --net host \
    kevineye/shairport-sync
	/snapserver.sh -s "spotify:///librespot?name=Spotify&devicename=Snapcast&bitrate=320&username=<USERNAME>&password=<PASSWORD>" -s "airplay:///usr/local/bin/shairport-sync?name=Airplay"
