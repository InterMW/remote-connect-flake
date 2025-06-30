mac=
echo $mac
echo $(curl -d '{"serialNumber":"'$(echo $(getmac) | tr -d '\n')'", "ipAddress":"'$(curl https://ipinfo.io/ip)'"}' -H "Content-Type: application/json" -X POST https://api.centurionx.net/device/register)
