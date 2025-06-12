# 2025-06-12 11:55:31 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=mikrotik-chr.nube
#
# Establece una contraseña al usuario admin
/user/set admin password=MiPass2025
#
#
#
/ip neighbor discovery-settings
set discover-interface-list=none
/interface ovpn-server server
add name=ovpn-server1 auth=sha1 certificate=certificado cipher=null disabled=no netmask=32 port=2025
/ip dhcp-client
add interface=ether1 use-peer-ntp=no
/ip firewall filter
add action=accept chain=input comment="Permitir Establecidos y Relacionados" connection-state=established,related in-interface=ether1
add action=accept chain=input comment=Winbox dst-port=8291 in-interface=ether1 protocol=tcp
add action=accept chain=input comment=OpenVPN-Servidor dst-port=2025 in-interface=ether1 protocol=tcp
add action=accept chain=input comment="Permitir Ping" in-interface=ether1 protocol=icmp
add action=drop chain=input comment="Bloquear todo" in-interface=ether1
/ip service
set ftp disabled=yes
set ssh disabled=yes
set telnet disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/ppp secret
add local-address=10.224.255.0 name=negocio1 password=Pass01 remote-address=10.224.255.1 routes=10.32.0.0/11 service=ovpn
add local-address=10.224.255.0 name=negocio2 password=Pass02 remote-address=10.224.255.2 routes=10.64.0.0/11 service=ovpn
/system clock
set time-zone-autodetect=no time-zone-name=America/Mexico_City
/system ntp client
set enabled=yes
/system ntp client servers
add address=time1.google.com
add address=time2.google.com
/tool bandwidth-server
set enabled=no
