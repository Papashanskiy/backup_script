> Команда восстановления базы данных при потере данных

```sh
$ cat dump_23-11-2020_09_29_53.sql | sudo docker exec -i ${CONTAINER_NAME} psql -U ${DB_USERNAME} -d ${DB_NAME}
```