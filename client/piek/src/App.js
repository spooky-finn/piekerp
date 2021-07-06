import ReactTooltip from 'react-tooltip';
import {observer} from 'mobx-react-lite';

import BaseLayout from './components/BaseLayout';

import './theme.css';
import './index.sass';



function App({sessionData}) {  
  return (
    <>
      <div className="App">
        

          <BaseLayout/>
            
      </div>
    <ReactTooltip id='global' type="light" place="bottom" delayShow={300} className='tooltip'/>
    </>
  );
}

export default observer(App);
