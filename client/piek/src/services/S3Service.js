import axios from 'axios';

export default class S3Service {
    
    static async uploadFile(acceptedFiles, OrderID){

        const formData = new FormData()
        acceptedFiles.map(file => formData.append('files', file))
        const res = await axios.put(`${process.env.REACT_APP_API_URL}/s3`, formData, {
            headers: {
              "Content-Type": "multipart/form-data",
              "orderid": OrderID
            }
          });
        return res
    }

    // static async downloadFile(file){
    //     return await axios.get(`${process.env.REACT_APP_API_URL}/s3/${file.Key}`)
    // }

    static  async deleteFile(key, deleteFileMutation){
        const res = await axios.delete(`${process.env.REACT_APP_API_URL}/s3/${key}`);

        if (res.status !== 200) return 'server error during delete file'

        return await deleteFileMutation({variables: {
            'key': key,
        }})
    }

}