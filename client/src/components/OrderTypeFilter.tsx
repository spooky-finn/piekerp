import Select, { SelectChangeEvent } from '@mui/material/Select'
import MenuItem from '@mui/material/MenuItem'
import { OrderStatus } from 'src/types/global'
import { FormControl, InputLabel } from '@mui/material'

interface IOrderTypeFilterProps {
  value: OrderStatus | ''
  onChange: (e: SelectChangeEvent) => void
}

export default function OrderTypeFilter({ value, onChange }: IOrderTypeFilterProps) {
  return (
    <FormControl>
      <InputLabel>Тип</InputLabel>
      <Select name="managerFilter" value={value as string} onChange={onChange}>
        <MenuItem value={OrderStatus.ordArchived}>Заказы</MenuItem>
        <MenuItem value={OrderStatus.reclArchived}>Рекламации</MenuItem>
      </Select>
    </FormControl>
  )
}
