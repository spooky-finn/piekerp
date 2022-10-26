import { MockedProvider } from '@apollo/client/testing'
import { render, screen } from '@testing-library/react'
import UserEvent from '@testing-library/user-event/'
import InputForm from '../InputForm'

function setup() {
  const mockInsertHandler = jest.fn()
  render(
    <MockedProvider>
      <InputForm insertComment={mockInsertHandler} inputRef={{ current: null }} />
    </MockedProvider>
  )

  const inputFormEl = screen.getByTestId('inputForm') as HTMLDivElement

  return {
    mockInsertHandler,
    inputFormEl
  }
}

test('should be able to input', async () => {
  const { inputFormEl } = setup()

  await UserEvent.type(inputFormEl, 'my super comment')
  expect(inputFormEl.innerHTML).toBe('my super comment')
})

test('should call insert handler on submit', async () => {
  const { inputFormEl, mockInsertHandler } = setup()
  const submitBtn = screen.getByRole('button')

  await UserEvent.type(inputFormEl, 'my super comment')
  await UserEvent.click(submitBtn)

  expect(mockInsertHandler).toBeCalledTimes(1)
})

test('should open menu and remove symbol when types slash [/]', async () => {
  const { inputFormEl } = setup()
  await UserEvent.type(inputFormEl, 'something /')

  expect(inputFormEl.textContent!.trim()).toBe('something')

  expect(screen.getByText('Чеклист')).toBeVisible()
  expect(screen.getByText('Упомянуть')).toBeVisible()
})

test('should add checkbox into inputForm', async () => {
  const { inputFormEl } = setup()
  await UserEvent.type(inputFormEl, '/')

  const checkListBtn = screen.getByText('Чеклист')
  await UserEvent.click(checkListBtn)

  expect(screen.getByTestId('checkListUnit')).toBeInTheDocument()
})
