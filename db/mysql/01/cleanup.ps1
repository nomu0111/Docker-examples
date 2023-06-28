
$a =  podman ps -a |Select-String -Pattern ".*mysql.*"

$array = -split $a

# write-host $array[0]
podman rm $array[0] -f

Remove-Item -Recurse -Force ./db/data/*