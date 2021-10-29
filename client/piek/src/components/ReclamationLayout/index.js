import sass from './index.module.sass'
import { Button, Typography } from "@mui/material"

import { UilWrench, UilPlus, UilArchive } from '@iconscout/react-unicons'

const Reclamation = (props) => {

  return(
    <div className={sass.reclatationLayout}>
       <div className='pageLayout__header'>
        <UilWrench className='pageLayout__icon'/>
        <div className="pageLayout__title">Рекламация</div>

        <div className='pageLayout__actions'>
          <Button variant='iconic'>
            <UilPlus/>
          </Button>
          <Button variant='iconic'>
            <UilArchive/>
          </Button>
        </div>
      </div>

    </div>
  )
}
export default Reclamation