#!/usr/bin/env bash

# ##############################################################################
#
# Aprovisionamiento de Rocky Linux.
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
echo -e " ${GREEN}Iniciando aprovisionamiento en Rocky Linux...${RESET}"
linea

echo -e "\n ${YELLOW}Actualizando el sistema...${RESET}"
linea
dnf update -y

echo -e "\n ${YELLOW}Instalando herramientas...${RESET}"
linea
dnf install bash-completion rsyslog chrony httpd bind-utils pciutils procps-ng psmisc mc glibc-langpack-en glibc-langpack-es glibc-common -y
sudo dnf install zip unzip tar gzip bzip2 xz lz4 zstd -y
sudo dnf groupinstall "Development Tools" -y
sudo dnf install kbd -y
sudo dnf install shadow-utils -y

echo -e "\n ${YELLOW}Configurando herramientas...${RESET}"
linea
systemctl enable --now rsyslog

echo -e "\n ${YELLOW}Desactivando firewall y SElinux...${RESET}"
linea
sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld

echo -e "\n ${YELLOW}Configuración idioma/teclado/hora...${RESET}"
linea
timedatectl set-local-rtc 0
timedatectl set-timezone "Europe/Madrid"
timedatectl
localectl
localectl set-locale LANG=es_ES.utf8
localectl set-keymap es
localectl

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
