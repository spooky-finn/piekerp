/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Button, TextField } from '@mui/material'
import axios from 'axios'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAppContext } from 'src/hooks'
import AuthService from 'src/services/AuthService'
import { ServerErrorResponse } from 'src/types/global'

const LoginForm = () => {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')

  const { store } = useAppContext()
  const navigate = useNavigate()

  const handleSubmit = async () => {
    try {
      const res = await AuthService.login(email, password)
      store.setInMemoryToken(res.data.accessToken)
      store.setUser(res.data.user)
      navigate('/')
    } catch (e: any) {
      if (axios.isAxiosError(e)) {
        setError((e.response?.data as ServerErrorResponse).error.message)
      } else {
        setError('There is probably not the network/server error.')
      }
    }
  }

  const loginCardStyles = css`
    display: flex;
    flex-direction: column;
    position: fixed;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    min-width: 300px;
    color: var(--highContrast);
    background: var(--L1);
    padding: 50px 20px;
    border-radius: var(--br);

    .button {
      margin-left: auto;
      margin-top: 1rem;
      color: var(--accent) !important;
    }

    .error {
      color: red;
      padding: 10px;
    }
  `

  return (
    <div css={loginCardStyles}>
      <h2>Piek ERP</h2>
      <TextField className="input" label="Email" onChange={e => setEmail(e.target.value.trim())} />
      <TextField
        label="Password"
        type="password"
        className="input"
        onChange={e => setPassword(e.target.value.trim())}
      />
      {error && <div className="error">{error}</div>}
      <Button className="button" variant="outlined" onClick={handleSubmit}>
        Войти
      </Button>
    </div>
  )
}

export default LoginForm
