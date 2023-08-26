import { makeAutoObservable, reaction } from 'mobx'
import { ChatState } from 'src/features/chat/chatState'
import AppState from './appState'
import Session from './session'

export type AppUser = {
  FirstName: string
  LastName: string
  UserID: number
}

export default class RootStore {
  initialized = false
  app: AppState
  chat: ChatState
  session: Session

  constructor() {
    makeAutoObservable(this)
    this.app = new AppState()
    this.session = new Session(this)
    this.chat = new ChatState(this)

    reaction(() => this.app.transport.ready, this.onTransportReady.bind(this))
  }

  private async onTransportReady() {
    await this.session?.init()
    this.chat?.ginit()

    this.initialized = true
  }

  get apolloClient() {
    return this.app?.transport?.apolloClient
  }

  get authenticated(): boolean {
    return Boolean(this.app.authStatus === 'ok')
  }
}
