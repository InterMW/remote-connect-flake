#!/bin/bash
autossh -N -M 32400 jump@jump.centurionx.net -R $(curl -s -d '{"serialNumber":"'$(getmac)'", "ipAddress":"'$(curl -s https://ipinfo.io/ip)'"}' -H "Content-Type: application/json" -X POST https://api.centurionx.net/device/register):localhost:22  -o "StrictHostKeyChecking no" 
