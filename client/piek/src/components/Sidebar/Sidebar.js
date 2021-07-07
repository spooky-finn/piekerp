// import { observer } from 'mobx-react-lite';
import { useContext } from 'react';
import { Context } from '../../index';

import { Pane } from 'evergreen-ui';
import './Sidebar.sass';
import { Link } from 'react-router-dom';
import * as Unicons from '@iconscout/react-unicons';


const Sidebar = () => {
    const {store} = useContext(Context);
    
    return(
        <>
            <Pane className='Sidebar'>

            <Link  className="action-icon" to='/'><Unicons.UilSortAmountDown/></Link>
            <Link  className="action-icon" to='/recently'><Unicons.UilEnvelopeInfo/></Link>
            <Link  className="action-icon" to='/reclamation'><Unicons.UilWrench/></Link>

            <Link  className="action-icon" to='/account'><Unicons.UilUserCircle/></Link>
            <Link  className="action-icon" to='/login' onClick={() => store.logout()}><Unicons.UilSignInAlt/></Link>



        </Pane>
        </>
    );
}

export default Sidebar;