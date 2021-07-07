import { useContext } from 'react';
import { Context } from '../../index';

import { Pane } from 'evergreen-ui';

import AppRouter from '../../routers/Router';

const BaseLayout = (props) => {
    const {store} = useContext(Context);
    

    return(
        <>
            <Pane className="base-container">
                
                    <AppRouter store={store} /> 

                    {props.children}
            </Pane>
        </>
    )
}   

export default BaseLayout;