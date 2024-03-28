#! /usr/bin/bash
# Universitat Potsdam
# Author Gaurav Sablok
# date: 2024-1-24
# generating the terraform installation files
read -r -p "please provide the link region:" region
read -r -p "please provide the number of the networks ipinterface:" ipinterface
read -r -p "please provide the provider:" provider
if [[ ${interface} == "ipaddress" ]]; then
    count=0
    interfacelink=()
    while [[ "${count}" -le "${ipinterface}" ]]; do
        read -r -p "please provide the network interface:" interface
        interfacelink+=("${interface}")
        ((count++))
    done
    echo "the provided interfaces are: ${interfacelink[*]}"
    for i in ${interfacelink[*]}; do
        echo "provider "${provider}" {
     profile =  "${i}"
     region  = "${region}"
}"
    done
elif [[ ${interface} = "file" ]]; then
    read -r -p "please provide the file name for the interface:" filename
    read -r -p "please provide the region for the instance creation:" region
    if [[ -f ${filename} ]]; then
        echo "the file is present"
        interfacelink=()
        for i in $(cat "${filename}" | cut -f 1 -d ","); do
            interfacelink+=("${i}")
            if [[ "${i}" == "" ]]; then
                break
            fi
        done
    fi
fi
for i in ${interfacelink[*]}; do
    echo "provider "${provider}" {
     profile =  "${i}"
     region  = "${region}"
}"
done
