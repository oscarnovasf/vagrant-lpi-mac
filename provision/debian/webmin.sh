#!/usr/bin/env bash

# ##############################################################################
#
# Instalación de Webmin.
#
#  url: https://192.168.33.11:10000
#  user: vagrant
#  pass: vagrant
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
echo -e " ${GREEN}Instalación de Webmin en Debian...${RESET}"
linea

echo -e "\n ${YELLOW}Instalando repositorios...${RESET}"
linea
curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh
sh webmin-setup-repo.sh -f

linea
echo -e " ${GREEN}Instalando Webmin...${RESET}"
linea
apt-get install webmin --install-recommends -y

linea
echo -e " ${GREEN}Instalación completada.${RESET}"
show_bye
