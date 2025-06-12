# 📘 Webinar: Gestión de VPN MikroTik v7 (Junio 2025)

Este repositorio contiene los archivos utilizados en el webinar de **junio de 2025**, donde se explicó paso a paso cómo implementar una **VPN segura entre múltiples sitios ISP** usando MikroTik RouterOS v7.

---

## 🧩 Contenido

| Archivo                  | Descripción                                                   |
|-------------------------|---------------------------------------------------------------|
| `00-EsquemaVPN.png`     | Diagrama completo de la topología utilizada durante el webinar |
| `01-CHR-Nube.rsc`       | Script para configurar el CHR en la nube con IP pública fija   |
| `02-Negocio-1.rsc`      | Configuración del primer sitio (Negocio 1)                     |
| `03-Negocio-2.rsc`      | Configuración del segundo sitio (Negocio 2)                    |
| `04-Torre33.rsc`        | Script para la torre 33 conectada al primer sitio              |
| `05-Torre65.rsc`        | Script para la torre 65 conectada al segundo sitio             |

Todos los scripts están diseñados para facilitar la conexión VPN entre sedes remotas, gestionadas desde un CHR centralizado en la nube. Se pueden importar vía **Winbox** o ejecutar desde la **CLI** de RouterOS.

---

## 🛡️ Tecnologías implementadas

- MikroTik CHR en la nube
- Enlaces DHCP cliente en sitios remotos
- Interconexión de redes LAN a través de túnel VPN
- Segmentación de red por bloques /11 y /24
- Topología híbrida cableada y virtualizada para emulación GNS3

---

📢 Si usas o compartes este material, no olvides dar crédito:  
[@jmiguelcd](https://github.com/jmiguelcd) | Ecatel LLC
