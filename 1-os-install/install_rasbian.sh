#!/bin/bash

# Script from https://jls42.org/raspberry-pi/initialisation-auto-de-raspbian-sur-raspberry-pi/

msd_fs="/dev/sdb"
mountpoint="/mnt/sdb"

[ -d ${mountpoint} ] || mkdir ${mountpoint}
[ -b ${msd_fs} ] || { echo  "${msd_fs} non disponible" ; exit 1 ;}

raspbian_version=""
if [ -z ${raspbian_version} ]
then
  raspbian_version=$(curl -s https://downloads.raspberrypi.org/raspbian_lite_latest | \
  grep "raspbian_lite"| perl -nle 'print $1 if /.*href=".*images\/.*\/([0-9].*)"/')
  if [ -e ${raspbian_version} ]
  then
    echo "La dernière image de Raspbian est déjà présente"
  else
    echo "Téléchargement de la dernière image de Raspbian"
    curl -s -L https://downloads.raspberrypi.org/raspbian_lite_latest --output ${raspbian_version}
  fi
fi  

echo -e "Déploiement de ${raspbian_version} to ${msd_fs}"
time unzip -p ${raspbian_version} | sudo dd of=${msd_fs} bs=4M conv=fsync && \
echo -e "Montage de ${msd_fs}1 to ${mountpoint}" && \
sudo mount ${msd_fs}1 ${mountpoint} && \
echo -e "Activation du SSH sur Rasbpian" && \
sudo touch ${mountpoint}/ssh && \
echo -e "Vérification de l'activation SSH" && \
sudo ls -l ${mountpoint}/ssh && \
echo -e "Démontage ${msd_fs}1" && \
sudo umount ${mountpoint}
