#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Ips data
ips_locales=$(hostname -I | cut -d '.' -f 1-2).1.1-254
first_octet=$ips_locales | cut -d '.' -f 1

if [ "$(id -u)" = "0" ]; then
  clear
  sleep 2
  echo -e "$blueColour->$endColour$yellowColour Se va a proporcionar un listado de los usuarios conectados a la red local$endColour\n"
  sleep 2
  echo -e "$redColour[Eso puede tardar unos segundos...]$endColour\n"
  nmap localhost -sP $ips_locales >> listado_ips && cat listado_ips | grep "MAC" | cut -d ' ' -f 3 >> listado_MACs
  cat listado_ips | grep "Nmap" | grep "$first_octet" | cut -d ' ' -f 5 >> listado_ipsG && rm listado_ips
  sed '/https:/d' listado_ipsG >> listado_ips && rm listado_ipsG
  sed '/localhost/d' listado_ips >> listado_ips2 && rm listado_ips && mv listado_ips2 listado_ips
  sed '/addresses/d' listado_ips >> listado_ips2 && rm listado_ips && mv listado_ips2 listado_ips

  while read line
    do

      echo "$line  -> " >> listado_Ips

  done < listado_ips

  rm listado_ips && mv listado_Ips listado_ips
  paste -d " " listado_ips listado_MACs >> listado_Nmap && rm listado_ips listado_MACs
  cat listado_Nmap
  echo " "
else
  clear
  echo -e "$redColour->AVISO:$endColour$yellowColour Es necesario entrar como superusuario$endColour\n"
  sleep 1
fi
