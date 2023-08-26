import moment from 'moment'
import { getRootStore } from 'src/store/storeProvider'
import { DeleteCommentDocument, UpdateCommentDocument } from 'src/types/graphql-shema'

export class ChatUser {
  constructor(public readonly id: number, public readonly name: string) {}
}
export interface ChatCommand {
  name: string
  onClick: (command: ChatCommand) => void
  description?: string
  icon?: React.ComponentType
  subCommands?: ChatCommand[]
}

export class ChatMessageGroup {
  constructor(public readonly messages: ChatMessage[]) {}
}

export class ChatMessage {
  apolloClient = getRootStore().apolloClient

  constructor(
    public readonly id: number,
    public message: string,
    public sender: ChatUser,
    public created_at: string
  ) {}

  public async remove() {
    // remove message from server
    await this.apolloClient.mutate({
      mutation: DeleteCommentDocument,
      variables: {
        id: this.id
      }
    })
  }

  public async updateMessage(message: string) {
    this.message = message

    await this.apolloClient.mutate({
      mutation: UpdateCommentDocument,
      variables: {
        id: this.id,
        message
      }
    })
  }

  public formatTimestamp() {
    return moment(this.created_at).format('DD.MM.YY hh:mm')
  }

  public isMine(myUserId: number) {
    return this.sender.id === myUserId
  }
}
