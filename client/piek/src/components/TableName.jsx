import Typography from '@mui/material/Typography'


export default function TableName({ name }){
    return (
        <Typography 
        variant = "subtitle1" 
        m       = '10px 10px' >
        {name} 
        </Typography>
    )
}