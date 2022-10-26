import FormGroup from '@mui/material/FormGroup'
import FormControlLabel from '@mui/material/FormControlLabel'
import Checkbox from '@mui/material/Checkbox'

export interface ICheckBoxProps {
  title: string
  value: boolean
  onClick: () => void
}

export default function CheckBox(props: ICheckBoxProps) {
  return (
    <FormGroup>
      <FormControlLabel
        control={<Checkbox value={props.value} onClick={props.onClick} />}
        label={props.title}
      />
    </FormGroup>
  )
}
