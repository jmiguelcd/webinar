# 2025-06-10 18:47:12 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=Balanceador
/tool romon set enabled=yes
# Creamos interfaces de LAN
/interface list
add name=LAN
#
# Creamos tablas de enrutamiento para cada interfaz de WAN
/routing table
add disabled=no fib name=Ruta_Ether1
add disabled=no fib name=Ruta_Ether2
#
# Asignamos direcciones IP
/ip address
add address=192.168.21.2/24 interface=ether1
add address=192.168.22.2/24 interface=ether2
add address=10.0.3.1/24 interface=ether3
#
# Ajustamos DNS
/ip dns set servers=8.8.8.8,8.8.4.4
#
# Creamos una lista con todas las ips privadas segun norma
/ip firewall address-list
add address=10.0.0.0/8 list=Ips_Privadas
add address=192.168.0.0/16 list=Ips_Privadas
add address=172.16.0.0/12 list=Ips_Privadas
#
# Reglas de marcado
/ip firewall mangle
# No marcamos consultas DNS y trafico entre redes privadas
add action=accept chain=prerouting port=53 protocol=udp
add action=accept chain=prerouting dst-address-list=Ips_Privadas src-address-list=Ips_Privadas
#
# Marcamos trafico que ingresa desde las WAN
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new in-interface=ether1 new-connection-mark=Conexion_1
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new in-interface=ether2 new-connection-mark=Conexion_2
#
# Empieza el marcado para balanceo
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-list=!Ips_Privadas dst-address-type=!local in-interface-list=LAN new-connection-mark=Conexion_1 per-connection-classifier=both-addresses:2/0
add action=mark-connection chain=prerouting connection-mark=no-mark connection-state=new dst-address-list=!Ips_Privadas dst-address-type=!local in-interface-list=LAN new-connection-mark=Conexion_2 per-connection-classifier=both-addresses:2/1
#
# En base a las marcas, enrutamos por diferentes enlaces de Internet
add action=mark-routing chain=prerouting connection-mark=Conexion_1 in-interface-list=LAN new-routing-mark=Ruta_Ether1 passthrough=no
add action=mark-routing chain=prerouting connection-mark=Conexion_2 in-interface-list=LAN new-routing-mark=Ruta_Ether2 passthrough=no
#
# Reglas de NAT, una por cada Interfaz de WAN
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=masquerade chain=srcnat out-interface=ether2
#
# Declaramos las rutas con Failover, con sondas hacia 4.2.2.1 y 4.2.2.2
/ip route
# Rutas para sonda
add distance=1 dst-address=4.2.2.1/32 gateway=192.168.21.1 scope=10
add distance=2 dst-address=4.2.2.1/32 scope=10 blackhole
add distance=1 dst-address=4.2.2.2/32 gateway=192.168.22.1 scope=10
add distance=2 dst-address=4.2.2.2/32 scope=10 blackhole
#
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=4.2.2.1 target-scope=11
add check-gateway=ping disabled=no distance=2 dst-address=0.0.0.0/0 gateway=4.2.2.2 target-scope=11
add check-gateway=ping disabled=no distance=3 dst-address=0.0.0.0/0 gateway=192.168.21.1
add check-gateway=ping disabled=no distance=4 dst-address=0.0.0.0/0 gateway=192.168.22.1
#
add disabled=no distance=1 dst-address=10.1.0.0/16 gateway=10.0.3.2 target-scope=10
add disabled=no distance=1 dst-address=10.2.0.0/16 gateway=10.0.3.2 target-scope=10
add disabled=no distance=1 dst-address=10.3.0.0/16 gateway=10.0.3.2 target-scope=10
#
#
# Reglas de enrutamiento, para que puedas acceder si tienes ips publicas por ambas ips
/routing rule
add action=lookup disabled=no dst-address=10.0.0.0/8 table=main
add action=lookup disabled=no dst-address=172.16.0.0/12 table=main
add action=lookup disabled=no dst-address=192.168.0.0/16 table=main
add action=lookup disabled=no src-address=192.168.21.0/24 table=Ruta_Ether1
add action=lookup disabled=no src-address=192.168.22.0/24 table=Ruta_Ether2
#
# Genera un log para avisar de caidas
/tool netwatch
add down-script=":log error \"Internet 1 - DOWN\"" host=4.2.2.1 interval=30s type=simple up-script=":log warning \"Internet 1 - UP\""
add down-script=":log error \"Internet 2 - DOWN\"" host=4.2.2.2 interval=30s type=simple up-script=":log warning \"Internet 2 - UP\""
#
