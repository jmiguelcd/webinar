# 2025-06-12 09:26:41 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=Torre33
/tool romon set enabled=yes
/ip address
add address=10.32.2.2/24 interface=ether2
add address=10.33.3.1/24 interface=ether3
/ip dns
set servers=8.8.8.8,8.8.4.4
/ip route
add gateway=10.32.2.1
/ip pool
add name=dhcp_pool0 ranges=10.33.3.100
/ip dhcp-server network
add address=10.33.3.0/24 gateway=10.33.3.1
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 name=dhcp1
