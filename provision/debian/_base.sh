#!/usr/bin/env bash

# ##############################################################################
#
# Aprovisionamiento de Debian.
#
# ##############################################################################

# Cierro el script en caso de error.
set -e

# ##############################################################################
# VARIABLES AUXILIARES.
# ##############################################################################

# Colores.
RESET="\033[0m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
GREEN="\033[0;32m"

# Control de tiempo de ejecución.
START=$(date +%s)

################################################################################
# FUNCIONES AUXILIARES.
################################################################################

# Simplemente imprime una línea por pantalla.
function linea() {
  echo '--------------------------------------------------------------------------------'
}

# Mensaje de finalización del script.
function show_bye() {
  # Calculo el tiempo de ejecución y muestro mensaje de final del script.
  END=$(date +%s)
  RUNTIME=$((END-START))

  linea
  echo -e " ${YELLOW}Tiempo de ejecución:${RESET} ${GREEN}${RUNTIME}s${RESET}"
  linea
  echo " "
}

################################################################################
# CUERPO PRINCIPAL DEL SCRIPT.
################################################################################

clear

linea
echo -e " ${GREEN}Iniciando aprovisionamiento en Debian...${RESET}"
linea

echo -e "\n ${YELLOW}Actualizando el sistema...${RESET}"
linea
sudo apt update -y

echo -e "\n ${YELLOW}Instalando herramientas...${RESET}"
linea
sudo apt install -y rsyslog bash-completion chrony apache2 dnsutils pciutils build-essential procps psmisc mc locales nfs-common
sudo apt install -y network-manager aptitude
sudo apt install -y zip unzip p7zip-full tar gzip bzip2 xz-utils lz4 zstd
sudo apt install -y console-setup keyboard-configuration
sudo apt install -y passwd login adduser

echo -e "\n ${YELLOW}Configurando herramientas...${RESET}"
linea
sudo systemctl enable --now rsyslog

# echo -e "\n ${YELLOW}Desactivando firewall...${RESET}"
# linea
# sudo systemctl disable ufw

echo -e "\n ${YELLOW}Configuración idioma/teclado/hora...${RESET}"
linea
echo "es_ES.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
sudo timedatectl set-timezone "Europe/Madrid"
sudo timedatectl
sudo localectl
sudo localectl set-locale LANG=es_ES.UTF-8

cat <<EOF | sudo tee /etc/default/keyboard
XKBMODEL="pc105"
XKBLAYOUT="es"
XKBVARIANT=""
XKBOPTIONS=""
EOF
sudo setupcon

echo -e "\n ${YELLOW}Configurando hosts...${RESET}"
linea
cat <<EOL | sudo tee /etc/hosts
127.0.0.1      localhost localhost.localdomain localhost4 localhost4.localdomain4
::1            localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.33.10  rocky.curso.local rocky
192.168.33.11  debian.curso.local debian
EOL

linea
echo -e " ${GREEN}Instalación completada.${RESET}"
show_bye
