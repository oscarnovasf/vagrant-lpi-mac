#!/usr/bin/env bash

# ##############################################################################
#
# Instalación de Docker.
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
echo -e " ${GREEN}Instalación de Docker en Rocky Linux...${RESET}"
linea

echo -e "\n ${YELLOW}Instalando repositorios...${RESET}"
linea
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

linea
echo -e " ${GREEN}Instalando Docker y dependencias...${RESET}"
linea
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

linea
echo -e " ${GREEN}Configurando...${RESET}"
linea
sudo systemctl --now enable docker
sudo usermod -aG docker $USER

linea
echo -e " ${GREEN}Instalación completada.${RESET}"
show_bye
