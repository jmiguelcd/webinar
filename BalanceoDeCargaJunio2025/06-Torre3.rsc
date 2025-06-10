# 2025-06-10 18:48:38 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=Torre3
/tool romon set enabled=yes
#
/ip address
add address=10.2.2.2/24 interface=ether1
add address=10.3.5.1/24 interface=ether5
/ip dns
set servers=8.8.8.8,8.8.4.4
/ip pool
add name=dhcp_pool0 ranges=10.3.5.100
/ip dhcp-server network
add address=10.3.5.0/24 gateway=10.3.5.1
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether5 name=dhcp1
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=10.2.2.1
#
#
#
