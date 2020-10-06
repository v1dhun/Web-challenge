#!/bin/bash

create(){
IP=$(curl ipinfo.io -s | head -n2 | tail -n1 | awk '{ print $2}' | sed 's/"//g' | sed 's/,//g')
echo "[+]Public ip : $IP"
IFS='.' read -ra ADDR <<< "$IP"
echo  "[+]Setting json file as ${ADDR[2]}.${ADDR[1]}.${ADDR[0]}.in-addr.arpa.json"
cp dns/216.184.93.in-addr.arpa.json backup/216.184.93.in-addr.arpa.json.bk 
sed "s/216.184.93.IN-ADDR.ARPA/${ADDR[2]}.${ADDR[1]}.${ADDR[0]}.IN-ADDR.ARPA/"  dns/216.184.93.in-addr.arpa.json > "dns/.${ADDR[2]}.${ADDR[1]}.${ADDR[0]}.in-addr.arpa.json"
sed "s/\"6\"/\"${ADDR[3]}\"/" dns/.${ADDR[2]}.${ADDR[1]}.${ADDR[0]}.in-addr.arpa.json > "dns/${ADDR[2]}.${ADDR[1]}.${ADDR[0]}.in-addr.arpa.json"
rm dns/.${ADDR[2]}.${ADDR[1]}.${ADDR[0]}.in-addr.arpa.json 
rm dns/216.184.93.in-addr.arpa.json
}

reset(){
rm dns/*.json
cp backup/216.184.93.in-addr.arpa.json.bk dns/216.184.93.in-addr.arpa.json
}


while getopts 'cr' o; do
    case "${o}" in
        c)
           	create
		   	;;
	    r)
		    cp dns/216.184.93.in-addr.arpa.json backup/216.184.93.in-addr.arpa.json.bk &> /dev/null	
            reset
			;;
        *)
            exit
            ;;
    esac
done