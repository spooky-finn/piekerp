/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { UilPalette } from '@iconscout/react-unicons'
import { FormControl, InputLabel, MenuItem, Select, Typography } from '@mui/material'
import Button from '@mui/material/Button'
import { Box } from '@mui/system'
import { ReactNode } from 'react'
import { useNavigate } from 'react-router-dom'

import { AppColorTheme } from 'src/types/global'
import { SystemPreferTheme } from '../../utils/systemPreferTheme'
import { useRootStore } from 'src/store/storeProvider'

export default function Settings() {
  const app = useRootStore().app
  if (!app.UItheme?.state || !app.UItheme?.dispatch) throw Error('theme dispatch dont exist in app')

  const { changeTheme } = SystemPreferTheme(app.UItheme.state, app.UItheme?.dispatch)
  const navigate = useNavigate()

  async function handleLogout() {
    await app.logout()
    navigate('/login')
  }

  const themeVariants: { title: string; value: AppColorTheme }[] = [
    {
      title: 'Светлая',
      value: 'light'
    },
    {
      title: 'Как на утройстве',
      value: 'system'
    },
    {
      title: 'Темная',
      value: 'dark'
    }
  ]

  const GridCard = ({ title, children }: { title: string; children: ReactNode }) => (
    <Box className="gridCard">
      <Typography variant="h6">{title}</Typography>
      {children}
    </Box>
  )

  const styles = css`
    margin: 1rem;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    column-gap: 20px;
    row-gap: 20px;

    .gridCard {
      background: var(--L1);
      border-radius: var(--br);
      line-height: 2;
      padding: 10px 20px 20px;
    }

    .theme {
      display: flex;
      align-items: center;
      column-gap: 15px;
    }
  `

  return (
    <div css={styles}>
      <GridCard title="Аккаунт">
        <div>
          {app.me?.FirstName} {app.me?.LastName}
        </div>
        <div> Уровень доступа: {(app.me as any).AccessLevelID}</div>
        <div> Email: {(app.me as any).Email}</div>
        <Button variant="contained" onClick={handleLogout} sx={{ mt: '10px' }}>
          Выйти
        </Button>
      </GridCard>

      <GridCard title="">
        <div className="theme">
          <UilPalette />
          <FormControl fullWidth>
            <InputLabel>Тема</InputLabel>
            <Select
              defaultValue={app.UItheme?.state}
              onChange={e => changeTheme(e.target.value as AppColorTheme)}
            >
              {themeVariants.map(each => (
                <MenuItem value={each.value} key={each.value}>
                  {each.title}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
        </div>
      </GridCard>

      <GridCard title="Data Provider">
        <div>https://{process.env.REACT_APP_HASURA_ENDPOINT}</div>
      </GridCard>
    </div>
  )
}
