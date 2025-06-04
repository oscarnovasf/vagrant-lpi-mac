Vagrant: LPI VM para MAC
===

[![version][version-badge]][changelog]
[![Licencia][license-badge]][license]
[![Código de conducta][conduct-badge]][conduct]

[![Donate][donate-badge]][donate-url] <img src="https://img.shields.io/liberapay/patrons/ONovasDev.svg?logo=liberapay">

---

## Información
Máquinas virtuales compatibles con MAC Silicon tanto con base RHL como Debian.

---

## Requisitos

### Requisitos del Sistema Host
- **macOS** con chips Apple Silicon (M1, M2, M3, etc.)
- **RAM mínima**: 8GB (recomendado 16GB o más)
- **Espacio en disco**: Al menos 20GB libres para las máquinas virtuales

### Software Requerido
- **VirtualBox** versión 7.1 o superior (con soporte para Apple Silicon)
- **Vagrant** versión 2.4.0 o superior
- **NFS** habilitado en macOS (para carpetas compartidas)

### Plugins de Vagrant (opcionales pero recomendados)
- `vagrant-vbguest` - Para gestión automática de Guest Additions
- `vagrant-disksize` - Para redimensionar discos virtuales

---

## Instalación
Para la instalación de este proyecto basta con clonar el repositorio como haría
con cualquier otro.

### Instalación de Dependencias
Es necesario tener instalado Virtualbox, se recomienda hacerlo desde la web
[oficial](https://www.virtualbox.org/wiki/Downloads) e instalar también el
"Extension Pack".

```bash
# Instalar VirtualBox
# (por si no se quiera hacer desde la web oficial)
brew install --cask virtualbox

# Instalar Vagrant
brew tap hashicorp/tap
brew install hashicorp/tap/hashicorp-vagrant

# Instalar plugins opcionales
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-disksize
```

### Verificación del Sistema
Antes de usar este proyecto, verifica que tu sistema cumple con los requisitos:
```bash
# Verificar versión de Vagrant
vagrant --version

# Verificar plugins instalados
vagrant plugin list

# Verificar VirtualBox
VBoxManage --version

# Verificar disponibilidad de NFS
sudo nfsd status
```

---

## Configuración

### Configuración de Red
- Rango de IPs `192.168.33.x` disponible para red privada
- Puertos opcionales para reenvío:
  - 8010, 8011 (HTTP)
  - 10010, 10011 (Webmin)

---
⌨️ con ❤️ por [Óscar Novás][mi-web] 😊

[mi-web]: https://oscarnovas.com "for developers"

[version]: v1.0.0
[version-badge]: https://img.shields.io/badge/Versión-1.0.0-blue.svg

[license]: LICENSE.md
[license-badge]: https://img.shields.io/badge/Licencia-GPLv3+-green.svg "Leer la licencia"

[conduct]: CODE_OF_CONDUCT.md
[conduct-badge]: https://img.shields.io/badge/C%C3%B3digo%20de%20Conducta-2.0-4baaaa.svg "Código de conducta"

[changelog]: CHANGELOG.md "Histórico de cambios"

[donate-badge]: https://img.shields.io/badge/Donaci%C3%B3n-PayPal-red.svg
[donate-url]: https://paypal.me/oscarnovasf "Haz una donación"
