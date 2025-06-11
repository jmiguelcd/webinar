# 2025-06-11 17:46:11 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=Borde-Firewall
/interface list
add name=Internet
add name=No-Descubrir
add name=Descubrir include=all exclude=dynamic,Internet,No-Descubrir
#
# Aqui añades a los puertos de Internet
#
/interface list member
add interface=ether1 list=Internet
#
/ip dns
set servers=9.9.9.9,149.112.112.112
/ip firewall filter
add action=accept chain=input comment="Establecido y Relacionado" connection-state=established,related in-interface-list=Internet
add action=accept chain=input comment=Winbox dst-port=8291 in-interface-list=Internet protocol=tcp
add action=drop chain=input comment="Bloquear Todo" in-interface-list=Internet
add action=drop chain=forward comment="Evitar Spam por SMTP" dst-port=25-26 protocol=tcp
/ip firewall raw
add action=drop chain=prerouting in-interface=ether3 src-address=!10.32.3.0/24
/ip route
add blackhole disabled=no distance=1 dst-address=1.180.230.98/32 gateway="" routing-table=main scope=30 suppress-hw-offload=no
/ip service
set ftp disabled=yes
set ssh disabled=yes
set telnet disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/tool bandwidth-server
set enabled=no
/tool romon set enabled=yes
/tool romon port add disabled=no forbid=yes interface=Internet
