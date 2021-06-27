import logo from './logo.svg';
import './App.css';
import { Component } from 'react';
import {Route, Switch} from 'react-router-dom';

import LoginPage from './pages/Login';

  class App extends Component {

    constructor(props) {
      super(props);
      this.state = { apiResponse: "" };
  }
  
  callAPI() {
      fetch("http://localhost:9000/testAPI")
          .then(res => res.text())
          .then(res => this.setState({ apiResponse: res }));
  }
  
  componentWillMount() {
      this.callAPI();
  }

  render() {
  return (
    <>
    
    <div className="App">
    <Switch>
      <Route path={'/login'} exact={true} component={LoginPage} />
    </Switch>
      
    </div>
    </>
  );
  }
}

export default App;
