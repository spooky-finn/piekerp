import {makeAutoObservable} from 'mobx';
import AuthService from '../services/AuthService';
import axios from 'axios';
import { API_URL } from '../http';

import { history } from '../routers/Router';

export default class Store {
    user = {};
    isAuth = false;

    constructor(){
        makeAutoObservable(this);
    }

    setAuth(bool){
        this.isAuth = bool;
    }

    setUser(user){
        this.user = user;
    }

    setLoading(bool){
        this.isLoading = bool;
    }

    async login(email, password){
        try {
            const response = await AuthService.login(email, password);
            localStorage.setItem('token', response.data.accessToken);
            this.setUser(response.data.user);
            this.setAuth(true);
            history.push('/');
        } catch (e) {
            console.log(e.response?.data?.message);
        }
    }

    async logout(){
        try {
            await AuthService.logout();
            localStorage.removeItem('token');
            this.setAuth(false);
            this.setUser({});
            history.push('/login');
        } catch (e) {
            console.log(e.response?.data?.message);
            
        }
    }

    async checkAuth() {
        this.setLoading(true);
        try {
            const response = await axios.get(`${API_URL}/refresh`, {withCredentials: true});
            localStorage.setItem('token', response.data.accessToken);
            this.setUser(response.data.user);
            this.setAuth(true);

            return {
                'isLoaded': true,
                 'isAuth': this.isAuth
                }
        } catch (e) {
            console.log(e.response?.data?.message);
            return {
                'isLoaded': true,
                'isAuth': this.isAuth
            }

        } finally {
            this.setLoading(false);
        }
        
    }
}
