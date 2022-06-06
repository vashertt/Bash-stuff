#! /bin/bash
tiempoini=`date +%T`

while [ TRUE ]
do
clear
echo ""
echo "Network config" `date`
echo ""
echo "1. Crear archivo personal de un alumno de IA2DA"
echo ""
echo "  2. Añadir alumnos a alumnos.txt"
echo ""
echo "      3. Control de Alumnos Faltas de asistencia"
echo ""
echo "S) Salir " `date +%T`
echo ""
read -p " Introduce un valor " valor
case $valor in
    1)
        clear
        echo 1. Crear archivo personal de un alumno de IA2DA
        read -p "Introduce el nombre del usuario: " usu
        fich="$usu.txt"
        if [ -f "GrupoB/alumnos/IA2DA/$fich" ];then
            echo "Ya existe este alumno"
            read r 
        else 
            read -p "Introduce el código del alumno: " codigo
            read -p "Introduce el nombre y apelldos: " name sn1 sn2 
            read -p "Introduce el número de teléfono: " tlf
            read -p "Introduce el número de faltas: " faltas
            iee="*"
            ies=" "
            todo="$codigo$iee$name$ies$sn1$ies$sn2$iee$tlf$iee$faltas"
            echo $todo > "GrupoB/alumnos/IA2DA/$fich"
            echo Alumno creado el archivo $fich
            read a
        fi
        ;;     
    2)
        new="S"
        while [ "$new" = "S" -o "$new" = "s" ]
        do
        clear
        echo 2. Añadir alumnos a alumnos.txt
        read -p "Introduce el curso del alumno: " curso2
        read -p "Introduce el DNI del alumno: " dni2
        read -p "Introduce el nombre y apellidos: "  name2 sn12 sn22
        read -p "Introduce la password: " pwd2
        iee2=":"
        ies=" "
        todo2="$curso2$iee2$dni2$iee2$name2$ies$sn12$ies$sn22$iee2$pwd2"
        grep "$dni2" GrupoB/alumnos/alumnos.txt
        if [ $? -eq 0 ];then
            echo El alumno ya existe
            read a
            clear
        else    
            echo $todo2 >> GrupoB/alumnos/alumnos.txt
            echo Alumno añadido
            read a
            cat GrupoB/alumnos/alumnos.txt
            read a 
            clear
        fi 
        read -p "Deseas añadir nuevo alumno S/N " new
        done
        ;;
    3)
        clear
        echo 3. Control de Alumnos Faltas de asistencia
        read -p " Introduce un usuario: " usu3
        fich3="$usu3.txt"
        if [ -f "GrupoB/alumnos/IA2DA/$fich3" ];then
            busca1=$(cut -f2 -d"*" GrupoB/alumnos/IA2DA/$fich3)
            busca2=$(cut -f4 -d"*" GrupoB/alumnos/IA2DA/$fich3)
            echo El nombre y apellido es: $busca1 tiene $busca2 faltas y el usuario es $usu3 .
            read a
            clear
        else
            echo El usuairio $usu3 no existe
            read a 
        fi
        ;;
    S|s)
        echo Elijo opcion S salir
        tiempofin=`date +%T`
        echo Hora de entrada $tiempoini
        echo Hora de salida $tiempofin
        read a
        break;;
    *) echo opción elegida $valor no válida para este menú ;;
    esac
    read p
done