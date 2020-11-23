> Команда восстановления базы данных при потере данных

```sh
$ cat dump_23-11-2020_09_29_53.sql | sudo docker exec -i iblog_db_1 psql -U hello_flask -d hello_flask_prod
```