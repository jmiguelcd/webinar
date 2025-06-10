# 2025-06-10 18:47:12 by RouterOS 7.19.1
# system id = OcjN7zESNgL
#
/interface ethernet
set [ find default-name=ether5 ] disable-running-check=no name=ether1
set [ find default-name=ether1 ] disable-running-check=no name=ether2
set [ find default-name=ether2 ] disable-running-check=no name=ether3
set [ find default-name=ether3 ] disable-running-check=no name=ether4
set [ find default-name=ether4 ] disable-running-check=no name=ether5
/interface list
add name=LAN
/port
set 0 name=serial0
/routing table
add disabled=no fib name=Ruta_Ether1
add disabled=no fib name=Ruta_Ether2
/ip address
add address=192.168.21.2/24 interface=ether1 network=192.168.21.0
add address=192.168.22.2/24 interface=ether2 network=192.168.22.0
add address=10.0.3.1/24 interface=ether3 network=10.0.3.0
/ip dns
set servers=8.8.8.8,8.8.4.4
/ip firewall address-list
add address=10.0.0.0/8 list=Ips_Privadas
add address=192.168.0.0/16 list=Ips_Privadas
add address=172.16.0.0/12 list=Ips_Privadas
/ip firewall mangle
add action=accept chain=prerouting port=53 protocol=udp
add action=accept chain=prerouting dst-address-list=Ips_Privadas \
    src-address-list=Ips_Privadas
add action=mark-connection chain=prerouting connection-mark=no-mark \
    connection-state=new in-interface=ether1 new-connection-mark=Conexion_1
add action=mark-connection chain=prerouting connection-mark=no-mark \
    connection-state=new in-interface=ether2 new-connection-mark=Conexion_2
add action=mark-connection chain=prerouting connection-mark=no-mark \
    connection-state=new dst-address-list=!Ips_Privadas dst-address-type=\
    !local in-interface-list=LAN new-connection-mark=Conexion_1 \
    per-connection-classifier=both-addresses:2/0
add action=mark-connection chain=prerouting connection-mark=no-mark \
    connection-state=new dst-address-list=!Ips_Privadas dst-address-type=\
    !local in-interface-list=LAN new-connection-mark=Conexion_2 \
    per-connection-classifier=both-addresses:2/1
add action=mark-routing chain=prerouting connection-mark=Conexion_1 \
    in-interface-list=LAN new-routing-mark=Ruta_Ether1 passthrough=no
add action=mark-routing chain=prerouting connection-mark=Conexion_2 \
    in-interface-list=LAN new-routing-mark=Ruta_Ether2 passthrough=no
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=masquerade chain=srcnat out-interface=ether2
/ip route
add distance=1 dst-address=4.2.2.1/32 gateway=192.168.21.1 scope=10
add blackhole distance=2 dst-address=4.2.2.1/32 scope=10
add distance=1 dst-address=4.2.2.2/32 gateway=192.168.22.1 scope=10
add blackhole distance=2 dst-address=4.2.2.2/32 scope=10
add check-gateway=ping distance=1 dst-address=0.0.0.0/0 gateway=4.2.2.1 \
    target-scope=11
add check-gateway=ping disabled=no distance=2 dst-address=0.0.0.0/0 gateway=\
    4.2.2.2 routing-table=main scope=30 suppress-hw-offload=no target-scope=\
    11
add check-gateway=ping distance=3 dst-address=0.0.0.0/0 gateway=192.168.21.1
add check-gateway=ping distance=4 dst-address=0.0.0.0/0 gateway=192.168.22.1
add disabled=no distance=1 dst-address=10.1.0.0/16 gateway=10.0.3.2 \
    routing-table=main scope=30 suppress-hw-offload=no target-scope=10
add disabled=no distance=1 dst-address=10.2.0.0/16 gateway=10.0.3.2 \
    routing-table=main scope=30 suppress-hw-offload=no target-scope=10
add disabled=no distance=1 dst-address=10.3.0.0/16 gateway=10.0.3.2 \
    routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/routing rule
add action=lookup disabled=no dst-address=10.0.0.0/8 table=main
add action=lookup disabled=no dst-address=172.16.0.0/12 table=main
add action=lookup disabled=no dst-address=192.168.0.0/16 table=main
add action=lookup disabled=no src-address=192.168.21.0/24 table=Ruta_Ether1
add action=lookup disabled=no src-address=192.168.22.0/24 table=Ruta_Ether2
/system identity
set name=Balanceador
/tool netwatch
add down-script=":log error \"Internet 1 - DOWN\"" host=4.2.2.1 interval=30s \
    type=simple up-script=":log warning \"Internet 1 - UP\""
add down-script=":log error \"Internet 2 - DOWN\"" host=4.2.2.2 interval=30s \
    type=simple up-script=":log warning \"Internet 2 - UP\""
/tool romon
set enabled=yes
