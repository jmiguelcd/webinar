# 2025-06-10 18:48:38 by RouterOS 7.19.1
# system id = XyZR9uAGPoI
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
/ip pool
add name=dhcp_pool0 ranges=10.3.5.100
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether5 name=dhcp1
/port
set 0 name=serial0
/ip address
add address=10.3.5.1/24 interface=ether5 network=10.3.5.0
add address=10.2.2.2/24 interface=ether1 network=10.2.2.0
/ip dhcp-server network
add address=10.3.5.0/24 gateway=10.3.5.1
/ip dns
set servers=8.8.8.8,8.8.4.4
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=10.2.2.1 routing-table=main \
    suppress-hw-offload=no
/system identity
set name=Torre3
/tool romon
set enabled=yes
