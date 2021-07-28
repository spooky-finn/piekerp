import { useContext, useEffect } from 'react';
import { Context } from './index';

import ReactTooltip from 'react-tooltip';
import {observer} from 'mobx-react-lite';

import BaseLayout from './components/BaseLayout';
import Sidebar from './components/Sidebar/sidebar';


function App() {  
  const {store} = useContext(Context);


  return (
    <>
      <div className="App">
        
        {store.isAuth
        ? <Sidebar/>
        : null}

      
          
          <BaseLayout/>
        
      </div>
      <ReactTooltip id='global' type="light" place="bottom" delayShow={300} className='tooltip'/>
    </>
  );
}

export default observer(App);
