#!SHELL
mac=$(getmac) | tr -d '\n'
echo $mac
echo $(curl -d '{"serialNumber":"'$mac'", "ipAddress":"'$(curl https://ipinfo.io/ip)'"}' -H "Content-Type: application/json" -X POST https://api.centurionx.net/device/register)
