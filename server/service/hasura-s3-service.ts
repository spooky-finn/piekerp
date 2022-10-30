import HasuraClient from '../lib/HasuraClient'

class HasuraS3Service extends HasuraClient {
  // add file metadata to hasura
  async addFileInformation(objects) {
    const query = ` 
        mutation MyMutation($objects: [erp_Docs_insert_input!]!) {
            insert_erp_Docs(objects: $objects) {
                returning {
                ID
                Key
                }
            }
        }`

    const variables = { objects }
    const res = await this._send(query, variables)
    return res.data.insert_erp_Docs.returning
  }

  async removeFileInformation(Key) {
    const query = `
        mutation MyMutation($Key: String!) {
            delete_erp_Docs(where: {Key: {_eq: $Key} }) {
                returning {
                Key
                }
            }
        }`
    const variables = { Key }
    const res = await this._send(query, variables)
    return res.data.delete_erp_Docs.returning
  }
}
export default new HasuraS3Service()
