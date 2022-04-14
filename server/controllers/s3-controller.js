const S3_HasuraQuery = require('../hasura-queries/s3');
const S3Service = require('../service/s3-service')

class S3Controller {
    async removeSingleFile(req, res, next){
        /**
        * Incoming request must contain a 'orderid'(integer) parameter in request headers. 
        * The `Request` object will be populated with a `files` object containing
        * information about the processed file.
        * 
        * hasuraUpload method adds file metadata into database using graphql server.
        */
        const key = req.params.key;
        S3Service.deleteObject(key).then(s3_responce => {
            S3_HasuraQuery.removeFileInformation(key)
            .then(data => {
                if (data.errors){
                    // If it is not possible to add metadata about the file to the database,
                    //  then we will execute a request to object storage to delete files
                    throw new Error(data.errors)
                }
                res.send(data)
            })
            .catch(err => {
                res.status(500).send({ message: `The grapql server is unviable. ${err}` })
            })

        }).catch(err => {
            res.status(500).send(err.message)
        })
   }

    async uploadBinaryFiles(req, res, next){
         /**
         * Incoming request must contain a 'orderid'(integer) parameter in request headers. 
         * The `Request` object will be populated with a `files` object containing
         * information about the processed file.
         * 
         * hasuraUpload method adds file metadata into database using graphql server.
         */
        const array_of_files = req.files.map(each => ({
            'Key': each.key,
            'OrderID': (req.headers.orderid),
            'FileName': each.originalname,
            'Size': each.size
        }));

        S3_HasuraQuery.addFileInformation(array_of_files)
        .then(data => data.json())
        .then( data => {
            if (data.errors){
                console.error(data.error);
                // If it is not possible to add metadata about the file to the database,
                //  then we will execute a request to object storage to delete files
                array_of_files.map(each => {
                    S3Service.deleteObject(each.Key)
                })
                throw new Error(data.errors);
            }
            res.send(req.files)
        })
        .catch(err => {
            res.status(500).send({ message: `The grapql server is unviable. ${err}` })
        })
    }

    async getBinaryFile(req, res, next){
        S3Service.getObject(req.params.key)
        .then(data => {
            const fileName = encodeURI(data.Metadata.originalname)
            res.set('Content-Type', data.ContentType); 
            res.set('Content-Disposition', `inline;filename*=utf-8''${fileName}`)
            res.send(data.Body);
        }).catch( e => {
            console.log(e)
            res.status(404).send({ error: e.message })
        })
    }
    

}

module.exports = new S3Controller();