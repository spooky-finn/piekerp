import $api from '../http';

export default class S3Service {
    static s3_url  = '/s3/'
    static async uploadFile(acceptedFiles, OrderID){

        const formData = new FormData()
        acceptedFiles.map(file => formData.append('files', file))

        const res = await $api.put(this.s3_url, formData, {
            headers: {
              "Content-Type": "multipart/form-data",
              "orderid": OrderID
            }
          });
        return res
    }


    static  async deleteFile(key, deleteFileMutation){
        const res = await $api.delete(this.s3_url + key);

        if (res.status !== 200) return 'server error during delete file'

        return await deleteFileMutation({variables: {
            'key': key,
        }})
    }

}