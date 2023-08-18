/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { UilTimes } from '@iconscout/react-unicons'
import { Button } from '@mui/material'
import moment from 'moment'
import { TOrderDocument } from 'src/types/global'
import { formatAssociatedIcon, formatBytes } from './utils'

interface IDocUnitProps {
  file: TOrderDocument
  handleOnDelete: (file: TOrderDocument) => void
  uploading?: boolean
  editState: boolean
}

export default function DocUnit({ file, handleOnDelete, uploading, editState }: IDocUnitProps) {
  const styles = css`
    padding: 8px 10px;
    display: flex;
    a {
      flex-grow: 1;
      display: grid !important;
      grid-template-columns: auto 1fr;
      grid-template-areas: 'svg name' 'svg date';

      &:hover {
        svg,
        .name {
          color: var(--accent);
        }
      }

      svg {
        grid-area: svg;
        color: var(--lowContrast);
        padding-right: 8px;
        stroke-width: 0.8;
        stroke: var(--L0);
      }

      .name {
        grid-area: name;
      }

      .date {
        grid-area: date;
        color: var(--lowContrast);
        font-size: 0.9rem;
      }
      button {
        padding: 0px 4px;
      }
    }
  `

  return (
    <div css={styles}>
      <a href={`${process.env.REACT_APP_API_URL}/s3/${file.Key}`} target="_blank" rel="noreferrer">
        {formatAssociatedIcon(file.FileName ?? '')}
        <div className="name">{file.FileName}</div>

        <div className="date" data-testid="filemeta">
          {formatBytes(file.Size!)} | {moment(file.UploadingDate).format('D MMMM')}
        </div>
      </a>

      {editState && (
        <Button variant="iconic" sx={{ padding: 0 }} onClick={() => handleOnDelete(file)}>
          <UilTimes />
        </Button>
      )}
    </div>
  )
}
