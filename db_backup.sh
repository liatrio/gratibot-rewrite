#!/bin/bash -eux

set -eux


export BACKUP_CONNECTION_STRING=''
export BACKUP_DB=''
export RESTORE_CONNECTION_STRING="${BACKUP_CONNECTION_STRING}"
export RESTORE_DB="${BACKUP_DB}"

BACKUP_DIR="mongodb_backup_$( date +%Y%m%d-%H%M%S)"

mongodump -d "${BACKUP_DB}" --gzip -v  -o "${BACKUP_DIR}" "${BACKUP_CONNECTION_STRING}"

mongorestore -d "${RESTORE_DB}" --gzip --writeConcern=0 -v --dryRun  "${RESTORE_CONNECTION_STRING}" "${BACKUP_DIR}/${BACKUP_DB}"
mongorestore -d "${RESTORE_DB}" --gzip --writeConcern=0 -v "${RESTORE_CONNECTION_STRING}" "${BACKUP_DIR}/${BACKUP_DB}"

