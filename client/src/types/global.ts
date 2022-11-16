import {
  CommentsSubscription,
  GetAllUsersQuery,
  GetEmployeeListQuery,
  GetNotificationsSubscription,
  GetOrderByPkQuery,
  GetReclamationOrdersQuery,
  OrderFragment
} from './graphql-shema'

export type ServerErrorResponse = {
  error: {
    message: string
    code: number
  }
}

export enum OrderStatus {
  ordRegistration = 1,
  ordProduction = 2,
  ordArchived = 3,

  reclInbox = 10,
  reclDecision = 11,
  reclProduction = 12,
  reclArchived = 13
}

export enum UserStatus {
  general = 1,
  management = 2,
  bookkeeping = 4,
  manufacture = 3
}

export type PreparedEmployeeDto = {
  id: number
  firstname: string
  lastname: string
  card: string

  intervals: Partial<{
    ent: string | null
    ext: string | null
    // the time between first entrance and last exit without gaps
    dur: number | null

    /**
     * -seconds
     * Суммарная длительность интервалов с учетом обеда, даже если человек отлучился во время работы в течении дня
     */
    durWithRetention_sec: number | null
    durWithRetention_human: string | null

    resolved: boolean | null
  }>[]

  /**
   *  - seconds
   * Чистое суммарное рабочее время c учетом обедов, но без поправок. Так сказать по факту
   */
  monthlyWithRetention: number

  /**
   *  - seconds
   *  Суммарное рабочее время за месяц с поправками на пустые интервалы
   *  т.е. Если сотрудник забыл отметиться при выходе, то рабочая смена будет считаться не законченной,
   *  и установится какое-то константное значение (4 часа)
   */
  monthlyWithRetentionResolved: number
}

export type AppColorTheme = 'light' | 'dark' | 'system'
export type AppColorMode = 'light' | 'dark'

export type Employee = GetEmployeeListQuery['attendance_users_aggregate']['nodes'][number]

export type TOrderItem = GetOrderByPkQuery['erp_Orders'][number]['OrderItems'][number]
export type TReclamationOrder = GetReclamationOrdersQuery['erp_Orders'][number]

export type TOrder = GetOrderByPkQuery['erp_Orders'][number]
export type TOrderColumnData = OrderFragment

export type TOrderDocument = GetOrderByPkQuery['erp_Orders'][number]['Docs'][number]
export type TPaymentsHistory = GetOrderByPkQuery['erp_Orders'][number]['PaymentHistories'][number]
export type TComment = CommentsSubscription['erp_Comments'][number]
export type TUser = GetAllUsersQuery['erp_Users'][number]
export type TNotification = GetNotificationsSubscription['erp_Notifications'][number]
