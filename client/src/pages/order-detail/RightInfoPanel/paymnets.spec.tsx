import { MockedProvider } from '@apollo/client/testing'
import { render, screen } from '@testing-library/react'
import { GetOrderPaymentsDocument, InsertPaymentDocument } from 'src/types/graphql-shema'
import PaymnetHistory, { NO_TOTAL_AMOUNT_MESSAGE } from './Payments'

jest.mock('src/hooks/useRootStore', () => ({
  useRootStore: () => ({
    app: {
      user: {
        AccessLevelID: 1
      }
    }
  })
}))

const mocks = [
  {
    request: {
      query: GetOrderPaymentsDocument,
      variables: {
        _eq: 1
      }
    },
    result: {
      data: {
        erp_PaymentHistory: [
          {
            ID: 1,
            Date: '2021-08-10T00:00:00.000Z',
            PaidAmount: 50_000
          },
          {
            ID: 2,
            Date: '2021-08-13T00:00:00.000Z',
            PaidAmount: 2_000_000
          }
        ]
      }
    }
  },
  {
    request: {
      query: InsertPaymentDocument,
      variables: {
        Date: '2022-08-14T21:00:00.000Z',
        PaidAmount: 2_100_000,
        OrderID: 1
      }
    },
    result: {
      data: {
        insert_erp_PaymentHistory_one: {
          ID: 3,
          OrderID: 1
        }
      }
    }
  }
]

beforeEach(() => {
  jest.clearAllMocks()
})

describe('order detail right info panel payments', () => {
  it('check message if total amount is 0', async () => {
    render(
      <MockedProvider mocks={mocks} addTypename={false}>
        <PaymnetHistory data={{ OrderID: 1, TotalAmount: 0 }} />
      </MockedProvider>
    )

    expect(await screen.findByText(NO_TOTAL_AMOUNT_MESSAGE)).toBeInTheDocument()
  })

  test('order detail right info panel payments', async () => {
    render(
      <MockedProvider mocks={mocks} addTypename={false}>
        <PaymnetHistory data={{ OrderID: 1, TotalAmount: 2_950_000 }} />
      </MockedProvider>
    )

    // expect that my two payments are rendered
    expect(await screen.findByText('10.08.21')).toBeInTheDocument()
    expect(await screen.findByText('13.08.21')).toBeInTheDocument()

    // verify that percentage is calculated correctly
    expect(await screen.findByText('2%')).toBeInTheDocument()
    expect(await screen.findByText('68%')).toBeInTheDocument()
  })

  it("verify that add new payment button is not rendered if user doesn't have full right", async () => {
    render(
      <MockedProvider mocks={mocks} addTypename={false}>
        <PaymnetHistory data={{ OrderID: 1, TotalAmount: 2950000 }} />
      </MockedProvider>
    )

    // check if element to present in the DOM
    expect(await screen.findByText('Добавить')).toBeInTheDocument()
  })

  // it('verify that can add new paymnet', async () => {
  //   render(
  //     <MockedProvider mocks={mocks} addTypename={false}>
  //       <PaymnetHistory data={{ OrderID: 1, TotalAmount: 2950000 }} />
  //     </MockedProvider>
  //   )

  //   fireEvent.click(await screen.findByText('Добавить'))

  //   // select input and type value
  //   fireEvent.change(await screen.findByLabelText('Дата'), {
  //     target: {
  //       value: '14.08.22'
  //     }
  //   })
  //   // select and type value get
  //   fireEvent.change(await screen.findByLabelText('Уже оплачено'), {
  //     target: {
  //       value: 2_100_000
  //     }
  //   })

  //   // click on save button
  //   fireEvent.click(await screen.findByText('Сохранить'))

  //   // verify that new payment is rendered
  //   // expect(await screen.findByText('14.08.22')).toBeInTheDocument()
  //   expect(await screen.findByText('68%')).toBeInTheDocument()
  // })

  // it('verify that can add new paymnet with default date', async () => {
  //   render(
  //     <MockedProvider mocks={mocks} addTypename={false}>
  //       <PaymnetHistory data={{ OrderID: 1, TotalAmount: 2_100_000 }} />
  //     </MockedProvider>
  //   )

  //   fireEvent.click(await screen.findByText('Добавить'))
  //   fireEvent.change(await screen.findByLabelText('Уже оплачено'), {
  //     target: {
  //       value: 2_100_000
  //     }
  //   })

  //   // click on save button
  //   fireEvent.click(await screen.findByText('Сохранить'))

  //   // verify that new payment is rendered
  //   // expect(await screen.findByText('15.08.21')).toBeInTheDocument()
  //   expect(await screen.findByText('100%')).toBeInTheDocument()
  // })
})
