import { $api } from 'src/api'

export default class FileService {
  static s3_url = '/s3/'

  static async uploadFile(acceptedFiles: File[], OrderID: number) {
    const formData = new FormData()
    acceptedFiles.map(file => formData.append('files', file))

    const res = await $api.put(this.s3_url, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
        orderid: OrderID
      }
    })
    return res
  }

  static async deleteFile(key: string) {
    return await $api.delete(this.s3_url + key)
  }
}
