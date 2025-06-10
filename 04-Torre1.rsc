# 2025-06-10 18:47:52 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=Torre1
/tool romon set enabled=yes
#
/ip address
add address=10.0.3.2/24 interface=ether1
add address=10.1.2.1/24 interface=ether2
add address=10.1.5.1/24 interface=ether5
/ip pool
add name=dhcp_pool0 ranges=10.1.5.100
/ip dhcp-server network
add address=10.1.5.0/24 gateway=10.1.5.1
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether5 name=dhcp1
/ip dns
set servers=8.8.8.8,8.8.4.4
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=10.0.3.1
add disabled=no distance=1 dst-address=10.2.0.0/16 gateway=10.1.2.2
add disabled=no distance=1 dst-address=10.3.0.0/16 gateway=10.1.2.2
#
#
#
