#!/bin/bash
echo $(curl -d '{"serialNumber":"'$(getmac)'", "ipAddress":"'$(curl https://ipinfo.io/ip)'"}' -H "Content-Type: application/json" -X POST https://api.centurionx.net/device/register)
