import { NavLink} from 'react-router-dom';
import './index.sass';

import { UilSortAmountDown, UilWrench, UilConstructor} from '@iconscout/react-unicons';
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
      <div className="link settings">
          {wrap(<SettingsDrawer/>)}
      </div>

    </div>
  );
}

export default Sidebar;