# 2025-06-10 18:46:11 by RouterOS 7.19.1
# system id = HL/tSHpX7/M
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
/port
set 0 name=serial0
/ip address
add address=192.168.21.1/24 interface=ether2 network=192.168.21.0
/ip dhcp-client
add interface=ether1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/system identity
set name=ISP-1
/tool romon
set enabled=yes
