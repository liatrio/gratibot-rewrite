#!/bin/bash -eux

set -eux

CONNECTION_STRING="$1"
BACKUP_DIR="$2"

RESTORE_DB="$3"



echo mongorestore -d "${RESTORE_DB}" --gzip --writeConcern=0 -v --dryRun  "${CONNECTION_STRING}" "${BACKUP_DIR}"
mongorestore -d "${RESTORE_DB}" --gzip --writeConcern=0 -v --dryRun  "${CONNECTION_STRING}" "${BACKUP_DIR}"

while true; do
    read -p "Do you wish to continue?" yn
    case $yn in
        [Yy]* ) mongorestore -d "${RESTORE_DB}" --gzip --writeConcern=0 -v "${CONNECTION_STRING}" "${BACKUP_DIR}"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done



