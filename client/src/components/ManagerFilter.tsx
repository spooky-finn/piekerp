import Select, { SelectChangeEvent } from '@mui/material/Select'
import MenuItem from '@mui/material/MenuItem'
import { useGetManagersQuery } from 'src/types/graphql-shema'
import { FormControl, InputLabel } from '@mui/material'

interface IManagerFilterProps {
  value: any
  onChange: (e: SelectChangeEvent<any>) => void
}

export default function ManagerFilter({ value, onChange }: IManagerFilterProps) {
  const { data, loading } = useGetManagersQuery()

  return (
    <FormControl>
      <InputLabel>Менеджер</InputLabel>
      <Select value={value} onChange={onChange}>
        <MenuItem value={0}>Все</MenuItem>

        {!loading &&
          data?.erp_Users.map(user => (
            <MenuItem value={user.UserID} key={user.UserID}>
              {`${user.FirstName} ${user.LastName}`}
            </MenuItem>
          ))}
      </Select>
    </FormControl>
  )
}
