# DynDNS in a Docker image for ARM64 devices
Just a little project for my Odroid C2.

## Deploy
```bash
docker run -d \
  --name dyndns \
  --restart=unless-stopped \
  -v /opt/docker/dyndns:/config \
  reverie89/dyndns:arm64
```

## Usage
1. Script by default loops every 30 minutes. Change value in seconds in `interval.txt`, it will be effective on next run. If you do not want to wait, restart the container with your preferred value in `interval.txt`.
2. Edit providers.txt. It will take effect on next run. If you do not want to wait, restart the container after editing the file.
```
http://freedns.afraid.org/dynamic/update.php?ENTER-YOUR-SECRET-API-HERE
https://www.duckdns.org/update?domains={YOURVALUE}&token={YOURVALUE}[&ip={YOURVALUE}][&ipv6={YOURVALUE}][&verbose=true][&clear=true]
https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$NEWIP
```

## How this works
The script will first check against `http://freedns.afraid.org/dynamic/check.php` to see if it matches what we already have. If this changes or oldIP file is not found, then update will be pushed.

## Did you know?
You can actually modify the base image in `Dockerfile` to fit any architecture in the *nix ecosystem and it will just work™.