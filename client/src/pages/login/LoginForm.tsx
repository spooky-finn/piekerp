/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Button, TextField } from '@mui/material'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAppContext } from 'src/hooks'
import AuthService from 'src/services/AuthService'

const LoginForm = () => {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')

  const { store } = useAppContext()
  const navigate = useNavigate()

  const handleSubmit = async () => {
    const res = await AuthService.login(email, password)
    if (res.status === 200) {
      store.setInMemoryToken(res.data.accessToken)
      store.setUser(res.data.user)
      navigate('/')
    } else {
      setError('Invalid email or password')
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
      {error && <div>{error}</div>}
      <Button className="button" variant="outlined" onClick={handleSubmit}>
        Войти
      </Button>
    </div>
  )
}

export default LoginForm
