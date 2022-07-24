
import Select from "@mui/material/Select"
import MenuItem from "@mui/material/MenuItem"
import CustomSelectWrapper from "./muiCustom/mui/CustomSelectWrapper"
import OS from '../lib/constants/OrderStatus'

const OrderTypeFilter = ({ value, onChange }) => (

    <CustomSelectWrapper isActive={false} helpText="Тип">
        <Select
            name="managerFilter"
            value={value}
            onChange={onChange}
        >
            <MenuItem value={OS.ordArchived}>Заказы</MenuItem>
            <MenuItem value={OS.reclArchived}>Рекламации</MenuItem>
        </Select>
    </CustomSelectWrapper>
)

export default OrderTypeFilter