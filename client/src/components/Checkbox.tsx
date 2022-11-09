import FormGroup from '@mui/material/FormGroup'
import FormControlLabel from '@mui/material/FormControlLabel'
import MuiCheckbox from '@mui/material/Checkbox'

export interface CheckboxProps {
  title: string
  value: boolean
  onClick: () => void
}

export default function Checkbox(props: CheckboxProps) {
  return (
    <FormGroup>
      <FormControlLabel
        control={<MuiCheckbox value={props.value} onClick={props.onClick} />}
        label={props.title}
      />
    </FormGroup>
  )
}
