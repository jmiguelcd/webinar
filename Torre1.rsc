# 2025-06-10 18:47:52 by RouterOS 7.19.1
# system id = n/RU/se9guH
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
/ip pool
add name=dhcp_pool0 ranges=10.1.5.100
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether5 name=dhcp1
/port
set 0 name=serial0
/ip address
add address=10.0.3.2/24 interface=ether1 network=10.0.3.0
add address=10.1.5.1/24 interface=ether5 network=10.1.5.0
add address=10.1.2.1/24 interface=ether2 network=10.1.2.0
/ip dhcp-server network
add address=10.1.5.0/24 gateway=10.1.5.1
/ip dns
set servers=8.8.8.8,8.8.4.4
/ip firewall nat
add action=masquerade chain=srcnat disabled=yes out-interface=ether1
/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=10.0.3.1 routing-table=main \
    suppress-hw-offload=no
add disabled=no distance=1 dst-address=10.2.0.0/16 gateway=10.1.2.2 \
    routing-table=main scope=30 suppress-hw-offload=no target-scope=10
add disabled=no distance=1 dst-address=10.3.0.0/16 gateway=10.1.2.2 \
    routing-table=main scope=30 suppress-hw-offload=no target-scope=10
/system identity
set name=Torre1
/tool romon
set enabled=yes
