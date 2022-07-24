
import Select from "@mui/material/Select"
import MenuItem from "@mui/material/MenuItem"
import CustomSelectWrapper from "./muiCustom/mui/CustomSelectWrapper"

export default function ManagerFilter({ value, onChange, managers }){

    return (
    <CustomSelectWrapper isActive={value} helpText="Менеджер">
            <Select
            name    = "managerFilter"
            value    = {value}
            onChange = {onChange} 
            >
                <MenuItem value={0}>Все</MenuItem>
                { Array.isArray(managers) && managers.map( (user) => 
                <MenuItem value={ user.UserID } key={user.UserID}> {`${user.FirstName} ${user.LastName}`} </MenuItem>
                )}
            </Select>
    </CustomSelectWrapper>
    )
}