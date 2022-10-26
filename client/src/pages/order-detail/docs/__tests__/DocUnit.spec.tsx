import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import DocUnit from '../DocUnit'

test('should display document filename', () => {
  render(
    <DocUnit
      editState={false}
      file={{
        ID: 12,
        Key: 'sdfsdf',
        FileName: 'SomeFile.pdf',
        Size: 123123123,
        UploadingDate: new Date()
      }}
      handleOnDelete={() => {}}
    />
  )
  expect(screen.getByText('SomeFile.pdf')).toBeInTheDocument()
})

test('should call handler if user click on delete button', async () => {
  const mockHandleOnClic = jest.fn()

  render(
    <DocUnit
      editState={true}
      file={{
        ID: 12,
        Key: 'sdfsdf',
        FileName: 'SomeFile.pdf',
        Size: 123123123,
        UploadingDate: new Date()
      }}
      handleOnDelete={mockHandleOnClic}
    />
  )

  const delButtonEL = screen.getByRole('button')
  expect(delButtonEL).toBeInTheDocument()

  await userEvent.click(delButtonEL)
  expect(mockHandleOnClic).toBeCalledTimes(1)
})

test('should properly convert file size', async () => {
  const mockHandleOnClic = jest.fn()

  render(
    <DocUnit
      editState={true}
      file={{
        ID: 12,
        Key: 'sdfsdf-123-123-12-3',
        FileName: 'SomeFile.pdf',
        Size: 100695,
        UploadingDate: new Date()
      }}
      handleOnDelete={mockHandleOnClic}
    />
  )

  const elem = screen.getByTestId('filemeta') as HTMLDivElement
  expect(elem.textContent).toContain('98.3 KB')
})
