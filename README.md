# rpi-keepalived
RPi-compatible Docker image with Keepalived

## Quick start
    docker run --name keepalived --cap-add=NET_ADMIN --net=host -d rvben/rpi-keepalived

## Environment Variables

The configuration can be set using environment variables:

    docker run \
    -e INTERFACE=eth1 \
    --name keepalived --cap-add=NET_ADMIN --net=host -d rvben/rpi-keepalived

- **INTERFACE**: Defaults to `eth0`
- **STATE**: Default state. Defaults to `BACKUP`
- **ROUTER_ID**: Virtual router ID. Defaults to `41`
- **PRIORITY** Node priority. Defaults to `100`
- **UNICAST_PEERS** Unicast peers, space-separated. Defaults to `192.168.2.101 192.168.2.102 192.168.2.103`
- **VIRTUAL_IPS**: Defaults to `192.168.2.100/24`
- **PASSWORD** Defaults to `KeptAliv`
- **NOTIFY** Notify script. Defaults to `/notify.sh`

## Configuration file
Example:

    docker run --name keepalived --cap-add=NET_ADMIN --net=host \
    -v $(pwd)/keepalived.conf:/etc/keepalived/keepalived.conf \
    -d rvben/rpi-keepalived

## Sources
[Oracle Linux Administrator's Guide](https://docs.oracle.com/cd/E37670_01/E41138/html/ol6-loadbal.html)
[osixia/docker-keepalived](https://github.com/osixia/docker-keepalived)
