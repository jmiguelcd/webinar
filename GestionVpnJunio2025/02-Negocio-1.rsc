# 2025-06-12 09:20:58 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=Negocio-1
/tool romon set enabled=yes
/interface ovpn-client
add name=ovpn-out1 connect-to=34.30.35.11 user=negocio1 password=Pass01 port=2025 use-peer-dns=no cipher=null
/ip address
add address=10.32.2.1/24 interface=ether2
/ip dhcp-client
add interface=ether1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/ip route
add dst-address=10.33.0.0/16 gateway=10.32.2.2
add disabled=no dst-address=10.224.0.0/11 gateway=10.224.255.0
add disabled=no dst-address=10.64.0.0/11 gateway=10.224.255.0
