# 2025-06-10 18:46:11 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=ISP-1
/tool romon set enabled=yes
#
#
/ip address
add address=192.168.21.1/24 interface=ether2
/ip dhcp-client
add interface=ether1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
#
#
