# The step by step tutorial to restore database from backup

1. Download backup from `thisdomain.ru/api/s3/get-backup/:key`
2. Move backup on the server using ssh `sudo scp -i ~/.ssh/piek ~/Downloads/dumpname.sql piekuser@45.10.110.58:~/`

4. Stop container with hasura 
3. Now probably should to delete our database fully if dump contains, in addition to data, also a scheme  `docker exec -i test-hasura_postgres_1 dropdb -p 61000 -U postgres postgres`
and `docker exec -i test-hasura_postgres_1 createdb -p 61000 -U postgres postgres`

If the postgres was using the standart port you didnt need to specify the port in next command

4. Restore database into the docker container `cat dump.sql | docker exec -i test-hasura_postgres_1 psql -U postgres -d postgres -p 61000`


