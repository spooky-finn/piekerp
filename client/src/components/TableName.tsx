import Typography from '@mui/material/Typography'

export default function TableName({ name }: { name: string }) {
  return (
    <Typography variant="subtitle1" m="10px 10px">
      {name}
    </Typography>
  )
}
