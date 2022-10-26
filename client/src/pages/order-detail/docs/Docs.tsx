/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Typography } from '@mui/material'
import { useEffect, useState } from 'react'
import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { TOrderDocument } from 'src/types/global'
import FileService from '../../../services/FileService'
import ConfirmDialog from './ConfirmDialog'
import DocUnit from './DocUnit'

interface IDocsProps {
  data: TOrderDocument[]
  refetch(): void
  onUpload: File[]
}

export default function Docs({ refetch, data, onUpload }: IDocsProps) {
  const { editMode } = useOrderDetailStore()
  const [open, setOpen] = useState(false)
  const [fileOnDelete, setFileOnDelete] = useState<TOrderDocument>()

  const handleClickOpenDialog = (file: TOrderDocument) => {
    setFileOnDelete(file)
    setOpen(true)
  }

  const handleCloseDialog = () => setOpen(false)

  useEffect(() => {
    setOpen(false)
  }, [editMode])

  const handleDeleteFile = async () => {
    //close modal window
    handleCloseDialog()

    // also removed file metadata from database
    await FileService.deleteFile(fileOnDelete?.Key!)
    refetch()
  }

  useEffect(() => {
    onUpload.map((file: File) => ({ ...file, FileName: file.name }))
  }, [onUpload])

  const titleStyles = css`
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 10px;
  `

  return (
    <div className="Docs">
      <div css={titleStyles}>
        <Typography variant="subtitle2">Документы [{data.length}]</Typography>
      </div>

      <div>
        {data.map(file => (
          <DocUnit
            key={file.Key}
            file={file}
            editState={editMode}
            handleOnDelete={handleClickOpenDialog}
          />
        ))}

        {!!onUpload.length &&
          onUpload.map(file => (
            <DocUnit
              file={{ ...file, FileName: file.name, Key: file.name, ID: 22 }}
              key={file.name}
              editState={editMode}
              handleOnDelete={handleClickOpenDialog}
              uploading
            />
          ))}
      </div>

      <ConfirmDialog
        filename={fileOnDelete?.FileName ?? ''}
        open={open}
        handleClose={handleCloseDialog}
        onConfirm={handleDeleteFile}
      />
    </div>
  )
}
