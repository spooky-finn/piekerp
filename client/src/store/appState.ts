import { makeAutoObservable } from 'mobx'
import React from 'react'
import { AppColorMode, AppColorTheme } from 'src/types/global'
import Transport from './transport'

type UItheme = {
  state: AppColorTheme
  dispatch: React.Dispatch<string>
}

type User = {
  Email: string
  FirstName: string
  LastName: string
  UserID: number
  AccessLevelID: number
}

export default class AppState {
  authStatus: 'ok' | 'err' | 'pending' | null = null
  me: User | null = null

  UItheme: UItheme | null = null
  colorMode: AppColorMode | null = null

  transport: Transport = new Transport(this)

  constructor() {
    makeAutoObservable(this)
    this.onInit()
  }

  setUser(user: typeof AppState.prototype.me) {
    this.me = user
  }

  setUItheme(state: UItheme['state'], dispatch: UItheme['dispatch']) {
    this.UItheme = { state, dispatch }
  }

  setAppColorMode(mode: AppColorMode) {
    this.colorMode = mode
  }

  async login(email: string, password: string) {
    try {
      const res = await this.transport.restClient!.post('/login', { email, password })
      if (res.status === 200) {
        this.transport.accessToken = res.data.accessToken
        this.setUser(res.data.user)
        this.authStatus = 'ok'
        return res
      }
    } catch (e) {
      this.authStatus = 'err'
      console.log(e)
    }
  }

  async logout() {
    try {
      await this.transport.restClient.post('/logout')
      this.transport.accessToken = null
      this.me = null
      this.authStatus = null
    } catch (e: any) {
      console.log(e.response?.data?.message)
    }
  }

  async refreshAccessToken(): Promise<string> {
    this.authStatus = 'pending'
    try {
      const res = await this.transport.restClient.get(`/refresh`, { withCredentials: true })
      this.me = res.data.user
      this.transport.accessToken = res.data.accessToken
      this.authStatus = 'ok'

      return res.data.accessToken as string
    } catch (e) {
      this.authStatus = 'err'
      throw e
    }
  }

  private async onInit() {
    await this.refreshAccessToken()
  }
}
