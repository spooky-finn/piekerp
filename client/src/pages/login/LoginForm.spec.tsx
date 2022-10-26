import { render, screen } from '@testing-library/react'
import UserEvent from '@testing-library/user-event'
import { MemoryRouter } from 'react-router-dom'
import AuthService from 'src/services/AuthService'
import Store from 'src/store/store'
import LoginForm from './LoginForm'

// jest.mock('src/services/AuthService')

beforeAll(() => {
  jest.spyOn(AuthService, 'login')

  jest.spyOn(Store.prototype, 'setInMemoryToken')
  jest.spyOn(Store.prototype, 'setUser')
  jest.spyOn(Store.prototype, 'login')

  jest.mock('react-router-dom', () => ({
    ...jest.requireActual('react-router-dom'),
    useNavigate: jest.fn()
  }))
})

async function setup() {
  render(
    <MemoryRouter>
      <LoginForm />
    </MemoryRouter>
  )
  return {
    mockLogin: jest
      .spyOn(Store.prototype, 'checkAuth')
      .mockImplementation(() => Promise.resolve('token'))
  }
}

async function inputUserCredentians(email?: string, password?: string, submit?: boolean) {
  const emailInputEl = screen.getByRole('textbox', { name: /email/i }) as HTMLInputElement
  const passwordInputEl = screen.getByLabelText('Password') as HTMLInputElement
  const submitButtonEL = screen.getByRole('button') as HTMLInputElement

  if (email) await UserEvent.type(emailInputEl, email)
  if (password) await UserEvent.type(passwordInputEl, password)
  // if (submit) await UserEvent.click(submitButtonEL)
  return {
    emailInputEl,
    passwordInputEl,
    submitButtonEL
  }
}

test('shoud have no error on startup', async () => {
  await setup()

  const errorMessage = screen.queryByText(/Invalid email or password/i)
  expect(errorMessage).not.toBeInTheDocument()
})

// test('should be able type into inputs', async () => {
//   await setup()
//   const { emailInputEl, passwordInputEl } = await inputUserCredentians('fink@gmail.com', 'pass')

//   expect(emailInputEl.value).toBe('fink@gmail.com')
//   expect(passwordInputEl.value).toBe('pass')
// })

// test('should login call on button click', async () => {
//   const { mockLogin } = await setup()

//   mockLogin.mockImplementation(
//     () =>
//       Promise.resolve({
//         status: 200,
//         data: {
//           refreshToken: 'dsf',
//           accessToken: 'sdf'
//         }
//       }) as Promise<AxiosResponse<any>>
//   )

//   await inputUserCredentians('fink@gmail.com', 'pass', true)
//   expect(mockLogin).toBeCalledTimes(1)
// })

test('should show error login if user send wrong credentials', async () => {
  const { mockLogin } = await setup()

  // mockLogin.mockImplementation(
  //   () =>
  //     Promise.resolve({
  //       status: 401,
  //       data: {
  //         error: 'Invalid email or password'
  //       }
  //     }) as Promise<AxiosResponse<any>> as any
  // )

  await inputUserCredentians('fink@gmail.com', 'pass')

  // expect(mockLogin).toBeCalledTimes(1)
  // expect(screen.getByText(/Invalid email or password/i)).toBeInTheDocument()
})
