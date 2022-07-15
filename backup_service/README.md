# The step by step tutorial to restore database from backup

1. Download backup on local
2. Move backup on the server using ssh `sudo scp -i ~/.ssh/piek ~/Downloads/dumpname.sql piekuser@45.10.110.58:~/`

4. Stop container with hasura `docker stop reserve_hasura`
3. Now probably should to delete our database fully if dump contains, in addition to data, also a scheme  
`docker exec -i reserve_db dropdb -p 61000 -U postgres postgres`
and `docker exec -i reserve_db createdb -p 61000 -U postgres postgres`

If the postgres was using the standart port you didnt need to specify the port in next command

5. Restore database into the docker container 
`cat dump.sql | docker exec -i reserve_db psql -U postgres -d postgres -p 61000`
6. Start container with hasura `docker start reserve_hasura`


