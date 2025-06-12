# 2025-06-12 11:55:31 by RouterOS 7.19.1
# Ecatel LLC - Ing. Jose Miguel Cabrera
#
/system identity set name=mikrotik-chr.nube
#
# Establece una contraseña al usuario admin
/user/set admin password=MiPass2025
#
#
# Desactivamos todo lo que no necesitamos en este proyecto
/ip service
set ftp disabled=yes
set ssh disabled=yes
set telnet disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/tool bandwidth-server
set enabled=no
/ip neighbor discovery-settings
set discover-interface-list=none
#
# Ajustamos la hora y zona horaria, activamos que se sincronice
/ip dhcp-client set use-peer-ntp=no [find]
/system clock
set time-zone-autodetect=no time-zone-name=America/Mexico_City
/system ntp client servers
add address=time1.google.com
add address=time2.google.com
/system ntp client
set enabled=yes
#
# Ya debes tener un certificado llamado "certificado" importado. Puedes verificar con: /certificate/print
# Levantamos el servidor VPN
/interface ovpn-server server
add name=ovpn-server1 auth=sha1 certificate=certificado cipher=null disabled=no netmask=32 port=2025
#
# Creamos credenciales para nuestros clientes
/ppp secret
add name=negocio1 password=Pass01 local-address=10.224.255.0 remote-address=10.224.255.1 routes=10.32.0.0/11 service=ovpn
add name=negocio2 password=Pass02 local-address=10.224.255.0 remote-address=10.224.255.2 routes=10.64.0.0/11 service=ovpn
#
# Implementamos Firewall
/ip firewall filter
add action=accept chain=input comment="Permitir Establecidos y Relacionados" connection-state=established,related in-interface=ether1
add action=accept chain=input comment=Winbox protocol=tcp dst-port=8291 in-interface=ether1 
add action=accept chain=input comment=OpenVPN-Servidor protocol=tcp dst-port=2025 in-interface=ether1
add action=accept chain=input comment="Permitir Ping" in-interface=ether1 protocol=icmp
add action=drop chain=input comment="Bloquear todo" in-interface=ether1
#

