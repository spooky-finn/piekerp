const fetch = require("node-fetch");
const ApiError = require("../exceptions/api-error");


class HasuraClient {
    endpoint = process.env.HASURA_ENDPOINT

    constructor() {
        if (this.constructor == HasuraClient) {
            throw new Error("Abstract classes can't be instantiated.");
        }
    }

    async _send(query, variables) {
        let responseData = await fetch(this.endpoint, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,
            },
            body: JSON.stringify({ query: query, variables: variables })
        })
        const res = await responseData.json()

        if (res.errors) {
            throw ApiError.HasuraServiceError('hasura-service-error', res.errors)
        }

        return res

    }
}

module.exports = HasuraClient;