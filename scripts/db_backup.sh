#!/bin/bash -eux

set -eux


export CONNECTION_STRING=$1
export BACKUP_DB=$2

BACKUP_DIR="mongodb_backup_$( date +%Y%m%d-%H%M%S)"

echo Running: mongodump -d "${BACKUP_DB}" --gzip -v  -o "${BACKUP_DIR}" "${CONNECTION_STRING}"


while true; do
    read -p "Do you wish to continue?" yn
    case $yn in
        [Yy]* ) mongodump -d "${BACKUP_DB}" --gzip -v  -o "${BACKUP_DIR}" "${CONNECTION_STRING}"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


