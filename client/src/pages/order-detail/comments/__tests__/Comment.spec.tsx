import { MockedProvider } from '@apollo/client/testing'
import { render, screen } from '@testing-library/react'
import UserEvent from '@testing-library/user-event/'
import Comment from '../Comment'

function setup(userID: number) {
  const { asFragment } = render(
    <MockedProvider>
      <Comment
        userID={userID}
        data={{
          CommentID: 112,
          Text: 'there is a comment',
          Timestamp: '2021-11-24T07:42:13.342852+00:00',
          User: {
            UserID: 15,
            FirstName: 'Fin',
            LastName: 'Kelstein'
          }
        }}
      />
    </MockedProvider>
  )
  return {
    asFragment
  }
}

test('snapshot test', () => {
  const { asFragment } = setup(15)
  expect(asFragment()).toMatchSnapshot()
})

test('should show delete button if user is the owner of comment', () => {
  setup(15)
  expect(screen.getByText('Удалить')).toBeInTheDocument()
})

test('should not display delete Btn', () => {
  setup(12)
  expect(screen.queryByText('Удалить')).not.toBeInTheDocument()
})

test('should be able for the owner to input something in content field', async () => {
  setup(15)
  const contentFiled = screen.getByText('there is a comment') as HTMLDivElement
  await UserEvent.type(contentFiled, 'something new')
  expect(contentFiled.textContent).toContain('something new')
})
