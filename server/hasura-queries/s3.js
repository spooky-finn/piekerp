const fetch = require("node-fetch");

class S3_HasuraQuery {
    endpoint = process.env.HASURA_ENDPOINT
    
    // add file metadata to hasura
    addFileInformation(objects) {
        return fetch(this.endpoint, {
            method: "POST",
            headers: {
            "Content-Type": "application/json",
            'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,
            },
            body: JSON.stringify({
                query: `
                mutation MyMutation($objects: [erp_Docs_insert_input!]!) {
                    insert_erp_Docs(objects: $objects) {
                      returning {
                        ID
                        Key
                      }
                    }
                }`,
                variables: {objects},
            })
        })
    }

    async removeFileInformation(Key) {
        let res = await fetch(this.endpoint, {
            method: "POST",
            headers: {
            "Content-Type": "application/json",
            'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,
            },
            body: JSON.stringify({
                query: `
                mutation MyMutation($Key: String!) {
                    delete_erp_Docs(where: {Key: {_eq: $Key} }) {
                        returning {
                        Key
                        }
                    }
                }`,
                variables: {Key},
            })
        })
        return res.json()
    }


}
module.exports = new S3_HasuraQuery();