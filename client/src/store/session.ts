import { makeAutoObservable } from 'mobx'
import {
  GetAllUsersDocument,
  GetAllUsersQuery,
  GetAllUsersQueryVariables
} from 'src/types/graphql-shema'
import RootStore, { AppUser } from './rootStore'

export default class Session {
  public users: AppUser[] = []

  constructor(private readonly rootStore: RootStore) {
    makeAutoObservable(this)
  }

  public async init() {
    const r = await this.rootStore.apolloClient.query<GetAllUsersQuery, GetAllUsersQueryVariables>({
      query: GetAllUsersDocument
    })

    this.users = r.data.erp_Users
  }
}
