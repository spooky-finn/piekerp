import { NavLink} from 'react-router-dom';
import './index.sass';

import { UilSortAmountDown, UilWrench, UilConstructor,  UilSetting} from '@iconscout/react-unicons';
import NotificationCenter from './NotificationCenter';
import SettingsDrawer from './SettingsDrawer/SettingsDrawer';

const Sidebar = () => {

  function wrap(icon){ 
    return <div className='iconWrapper'>{icon}</div>
  }

  return(
    <div className='Sidebar'>
      <NavLink  exact  to='/' activeClassName='sidebar-active' className="link">{wrap(<UilSortAmountDown/>)}</NavLink>
      <NavLink  to='/reclamation' activeClassName='sidebar-active' className="link">{wrap(<UilWrench/>)}</NavLink>
      <NavLink  to='/attendance' activeClassName='sidebar-active' className="link">{wrap(<UilConstructor/>)}</NavLink>
      
      <div className="link marginTopAuto">
          {wrap(<NotificationCenter/>)}
      </div>

      {/* <div className="link">
          {wrap(<SettingsDrawer/>)}
      </div> */}
      <NavLink  to='/settings' activeClassName='sidebar-active' className="link"> {wrap(<UilSetting/>) }</NavLink>

    </div>
  );
}

export default Sidebar;