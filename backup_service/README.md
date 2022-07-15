# guideline for restoring database from backup in docker

1. Download backup on local machine
2. Move backup to the server using ssh `sudo scp -i ~/.ssh/piek ~/Downloads/dumpname.sql piekuser@45.10.110.58:~/`

4. Stops container with hasura `docker stop reserve_hasura`
3. If dump contains, in addition to data, also a scheme u need to fully delete your database and create them again 
to delete: `docker exec -i reserve_db dropdb -p 61000 -U postgres postgres`
to create one: `docker exec -i reserve_db createdb -p 61000 -U postgres postgres`

If postgres using the standart port thath you dont need to specify port

5. Restore database into the docker container 
`cat dump.sql | docker exec -i reserve_db psql -U postgres -d postgres -p 61000`
6. Start container with hasura `docker start reserve_hasura`


