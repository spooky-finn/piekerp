import { makeAutoObservable, toJS } from 'mobx'
import { ChatCommand, ChatMessage, ChatUser } from 'src/features/chat/chatEntity'

import ChecklistRoundedIcon from '@mui/icons-material/ChecklistRounded'
import PersonAddAltRoundedIcon from '@mui/icons-material/PersonAddAltRounded'
import RootStore from 'src/store/rootStore'
import placeCaretAtEnd from 'src/utils/placeCaretAtEnd'
import { CommentsDocument, CommentsQuery, CommentsQueryVariables } from 'src/types/graphql-shema'

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

  constructor(private readonly rootStore: RootStore) {
    makeAutoObservable(this)
  }

  public ginit() {
    this.commands = this.topLevelCommands()
  }

  public topLevelCommands(): ChatCommand[] {
    const users = this.rootStore.session!.users
    const me = this.rootStore.app.me!
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
        },
        icon: PersonAddAltRoundedIcon,
        subCommands: users
          .filter(each => each.UserID !== me.UserID)
          .map(each => ({
            name: `${each.FirstName} ${each.LastName}`,
            onClick: () => {
              this.forceInputUpdate(`@${each.FirstName} ${each.LastName}`)
              this.commandMenuOpen = false
            }
          }))
      }
    ]
  }

  public async open(chatId: number, messageOperations: MessageOperations) {
    const data = await this.rootStore.apolloClient.query<CommentsQuery, CommentsQueryVariables>({
      query: CommentsDocument,
      variables: {
        OrderID: chatId
      }
    })

    const messages = data.data.erp_Comments.map((comment): ChatMessage => {
      const senser = new ChatUser(
        comment.User.UserID,
        comment.User.FirstName + ' ' + comment.User.LastName
      )
      return new ChatMessage(comment.CommentID, comment.Text, senser, comment.Timestamp)
    })

    this.addMessages(messages)

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
    // this.addMessages(new ChatMessage(0, this.inputRef.innerHTML))
    this.inputRef.innerText = ''
  }

  public handleEditMessage(message: ChatMessage) {
    this.setEditingMessage(message)
  }

  public handleDeleteMessage(message: ChatMessage) {
    this.messageOperations?.deleteMessage(message)
    this.messages = this.messages.filter(each => each.id !== message.id)
  }
}
