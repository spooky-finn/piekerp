# The step by step tutorial to restore database from backup

1. Download backup from 'thisdomain.ru/api/s3/get-backup/:key'
2. Move backup on the server using ssh: sudo scp -i ~/.ssh/piek ~/Downloads/dumpname.sql piekuser@45.10.110.58:~/
3. Copy dump to the container: docker cp dumpname.sql postgress_containername:./


