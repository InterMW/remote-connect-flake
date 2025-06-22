#!/bin/bash
echo $(getmac)
echo '{"serialNumber":"'$(getmac)'", "ipAddress":"'$(curl -s https://ipinfo.io/ip)'"}"' -H "Content-Type: application/json" -X POST https://api.centurionx.net/device/register
e=$(curl -d '{"serialNumber":"'$(getmac)'", "ipAddress":"'$(curl https://ipinfo.io/ip)'"}' -H "Content-Type: application/json" -X POST https://api.centurionx.net/device/register)
echo $e
echo $e
echo $e
echo $2
echo $2
echo $2
echo $e
autossh -M 32400 jump@jump.centurionx.net -R $e:localhost:22  -o "StrictHostKeyChecking no" 

