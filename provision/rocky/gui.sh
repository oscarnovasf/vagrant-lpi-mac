#!/usr/bin/env bash

# ##############################################################################
#
# Entorno gráfico de Rocky Linux.
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
echo -e " ${GREEN}Instalando entorno gráfico en Rocky Linux...${RESET}"
linea
dnf groupinstall -y "Server with GUI"
systemctl set-default graphical.target

# Verificar que gdm esté disponible después de la instalación
echo -e "\n ${YELLOW}Verificando GDM..${RESET}"
linea
if systemctl list-unit-files | grep -q gdm.service; then
  systemctl enable gdm
  echo -e "${GREEN}✅ GDM habilitado correctamente${RESET}"
else
  echo -e "${RED}❌ GDM aún no está disponible${RESET}"
fi

linea
echo -e " ${GREEN}Instalación completada. Reiniciando VM...${RESET}"
show_bye

# Reiniciar automáticamente
reboot
