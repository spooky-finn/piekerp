import { makeAutoObservable, toJS } from 'mobx'
import { ChatCommand, ChatMessage, ChatUser } from 'src/features/chat/chatEntity'

import PersonAddAltRoundedIcon from '@mui/icons-material/PersonAddAltRounded'
import ChecklistRoundedIcon from '@mui/icons-material/ChecklistRounded'
import placeCaretAtEnd from 'src/utils/placeCaretAtEnd'
import { AppUser } from 'src/store/rootStore'

export type MessageOperations = {
  insertMessage: (message: string) => Promise<void>
  updateMessage: (message: ChatMessage) => Promise<void>
  deleteMessage: (message: ChatMessage) => Promise<void>
}

export class ChatState {
  public messages: ChatMessage[] = []
  private messageOperations: MessageOperations | null = null
  public editingMessag: ChatMessage | null = null

  public inputRef: HTMLElement | null = null
  public commands: ChatCommand[] = []
  public commandMenuOpen = false
  public users: ChatUser[] = []

  public topLevelCommands = (): ChatCommand[] => {
    const users = this.users
    return [
      {
        name: 'Чеклист',
        onClick: () => {
          this.forceInputUpdate('Чеклист')
          this.commandMenuOpen = false
        },
        icon: ChecklistRoundedIcon
      },
      {
        name: 'Упомянуть',
        onClick: (command: ChatCommand) => {
          this.setCommands(command.subCommands || [])
          console.log(toJS(command))
        },
        icon: PersonAddAltRoundedIcon,
        subCommands: users.map(each => ({
          name: each.name,
          onClick: () => {
            this.forceInputUpdate(`@${each.name} `)
            this.commandMenuOpen = false
          }
        }))
      }
    ]
  }

  constructor(appUsers: AppUser[]) {
    makeAutoObservable(this)
    this.users = appUsers.map(
      each => new ChatUser(each.UserID, each.FirstName + ' ' + each.LastName)
    )
    this.commands = this.topLevelCommands()
  }

  public init(messageOperations: MessageOperations) {
    this.messageOperations = messageOperations
  }

  public addMessages(messages: ChatMessage[]) {
    this.messages = messages
  }

  public setInputRef = (ref: HTMLElement) => {
    this.inputRef = ref
  }

  public setCommands(commands: ChatCommand[]) {
    this.commands = commands
  }

  public forceInputUpdate(innerHTML: string) {
    ;(this.inputRef as HTMLDivElement).innerHTML = innerHTML
  }

  public setCommandMunuOpen(open: boolean) {
    this.commandMenuOpen = open
  }

  public handleCommandtInput() {
    if (!this.inputRef) throw new Error('Input ref is not set (^～^)')

    if (this.inputRef.innerText === '') {
      this.commands = this.topLevelCommands()
      this.commandMenuOpen = false
    }

    if (this.inputRef.innerText === '/') {
      this.commandMenuOpen = true
    }
  }

  public setEditingMessage(message: ChatMessage) {
    if (!this.inputRef) throw new Error('Input ref is not set (^～^)')

    this.editingMessag = message
    this.forceInputUpdate(message.message)
    this.inputRef.focus()
    placeCaretAtEnd(this.inputRef)
  }

  public async handleInputSubmin() {
    if (!this.inputRef) {
      throw new Error('Input ref is not')
    }

    if (this.editingMessag) {
      this.editingMessag.message = this.inputRef.innerHTML
      await this.messageOperations?.updateMessage(this.editingMessag)
      this.editingMessag = null
      return
    }

    this.setCommandMunuOpen(false)
    await this.messageOperations?.insertMessage(this.inputRef.innerHTML)
    this.inputRef.innerText = ''
  }

  public handleEditMessage(message: ChatMessage) {
    this.setEditingMessage(message)
  }

  public handleDeleteMessage(message: ChatMessage) {
    this.messageOperations?.deleteMessage(message)
  }

  // public async openChat(chatId: number) {
  //   const df = apolloClient.subscribe<CommentsSubscription, CommentsSubscriptionVariables>({
  //     query: CommentsDocument,
  //     variables: {
  //       OrderID: chatId
  //     }
  //   })

  // data.subscribe(({ data }) => {
  //   this.messages = data?.data?.erp_Comments.map(each => {
  //     const sender = new Sender(each.User.UserID, each.User.FirstName + ' ' + each.User.LastName)

  //     return new ChatMessage(each.CommentID, each.Text, sender, each.Timestamp)
  //   })
  // })
}
