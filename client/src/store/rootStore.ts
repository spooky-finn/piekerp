import { makeAutoObservable } from 'mobx'
import { ChatState } from 'src/features/chat/chatState'

export type AppUser = {
  FirstName: string
  LastName: string
  UserID: number
}

export default class RootStore {
  appUsers: AppUser[] = []
  chat: ChatState

  constructor() {
    makeAutoObservable(this)

    this.chat = new ChatState(this.appUsers)
  }
}
