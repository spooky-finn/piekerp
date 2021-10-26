import { Typography } from "@mui/material"
const BaseHeader = (props) => {

    return(
           <div className="page-header">
                    <span>{props.pageParams.icon}</span>
                    <Typography>{props.pageParams.title}</Typography>                    
                    {props.children}
            </div>
    )
}

export default BaseHeader