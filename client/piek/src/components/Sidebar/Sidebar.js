// import { observer } from 'mobx-react-lite';
import { useContext } from 'react';
import { Link } from 'react-router-dom';
import { Context } from '../../index';

import { Pane } from 'evergreen-ui';
import './sidebar.sass';
import { UilSortAmountDown, UilEnvelopeInfo, UilWrench, UilUserCircle, UilSignInAlt} from '@iconscout/react-unicons';
import { DarkToggle } from './DarkToggle';

const Sidebar = () => {
    const {store} = useContext(Context);

    return(
        <>
        <Pane className='Sidebar'>

            <Link  className="action-icon" to='/'><UilSortAmountDown/></Link>
            <Link  className="action-icon" to='/recently'><UilEnvelopeInfo/></Link>
            <Link  className="action-icon" to='/reclamation'><UilWrench/></Link>

           <a className="action-icon" ><DarkToggle/></a> 
            <Link  className="action-icon" to='/account'><UilUserCircle/></Link>
            <Link  className="action-icon" to='/login' onClick={() => store.logout()}><UilSignInAlt/></Link>



        </Pane>
        </>
    );
}

export default Sidebar;