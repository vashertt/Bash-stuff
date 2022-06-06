#! /bin/bash

while [ TRUE ]
do
clear
sudo rm -r temp --f
mkdir temp
ip a | grep "inet " | cut -f6 -d" " > temp/ip.txt
ip a | grep ": " | cut -d":" -f 2 > temp/inf.txt
touch temp/dhcp.txt
echo "  loopback" > temp/dhcp.txt
netplan get | grep dhcp >> temp/dhcp.txt
paste -d"                       " temp/inf.txt temp/ip.txt temp/dhcp.txt > temp/con.txt
echo ""
echo "Network config" `date`
echo ""
echo "Interface Address"
cat temp/con.txt
echo ""
echo "	1.Set Static IP"
echo ""
echo "	2.Set dynamic IP"
echo ""
echo "	3.Update"
echo ""
echo "	E.Exit"
echo ""
read -p "Select an option " val
case $val in
    1)
        clear
        echo "1.Set static IP"
	echo ""
	cat temp/con.txt
	echo ""
        read -p "Select interface: " interface
	cp /etc/netplan/00-installer-config.yaml /etc/netplan/backup.txt
        read -p "IP Address: " ip
	read -p "Gateway: " gw
	read -p "DNS: " dns
        sudo echo "network:
    version: 2
    renderer: networkd
    ethernets:
        $interface:
            dhcp4: false
            addresses:
                - $ip
            nameservers:
                addresses: [$dns]
            routes:
                - to: default
                  via: $gw" > /etc/netplan/00-installer-config.yaml
	sudo rm -r temp
	sudo netplan apply
        ;;
    2)
        clear
        echo "2.Set dynamic IP"
        echo ""
        cat temp/con.txt
        echo ""
        read -p "Select interface: " interface
        cp /etc/netplan/00-installer-config.yaml /etc/netplan/backup.txt
        sudo echo "network:
    version: 2
    renderer: networkd
    ethernets:
        $interface:
            dhcp4: true" > /etc/netplan/00-installer-config.yaml
	sudo rm -r temp
        sudo netplan apply
        ;;
    3)
	;;
    E|e)
        echo Bye
        read a
        break;;
    *) echo Not valid option ;;
    esac
    read p
done
