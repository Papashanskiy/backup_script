#!/bin/bash

BACKUP_DIR=/var/lib/#path_to_backups
DAYS_TO_KEEP=30
PROJECT=#project_name
DB_USER=#db_username
DB_PASSWORD=#db_pwd
DB=#db_name
CONTAINER_NAME=#container_name

prune_outdated() {
    find $BACKUP_DIR -maxdepth 1 -mtime +$DAYS_TO_KEEP -name "*${PROJECT}*" -exec rm -rf '{}' ';'
}

backup () {
    cmd=$1
    suffix=$2
    file="${BACKUP_DIR}/"`date +"%d-%m-%Y"_"%H_%M"`"_${PROJECT}${suffix}"
    tempfile="$(mktemp ${BACKUP_DIR}/.XXXXXXXX)"
    trap "rm -f '$tempfile'; exit 1" 0 1 2 3 13 15

    if ${cmd} > ${tempfile}
    then mv "${tempfile}" "${file}"
    else rm "${tempfile}"
    fi

    trap 0
}

# do the database backup (postgres custom-format archive)
backup "docker exec -t ${CONTAINER_NAME} pg_dumpall -c -U ${DB_USER}" ".sql"

prune_outdated
