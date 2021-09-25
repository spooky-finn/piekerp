
import {makeAutoObservable} from 'mobx';
import {Pane, Spinner} from 'evergreen-ui';
import AuthService from '../services/AuthService';
import axios from 'axios';
import { API_URL } from '../http';
import { UilWrench, UilConstructor} from '@iconscout/react-unicons';

export default class Store {
    user = {};
    isLoading = false;
    inMemoryToken = undefined;

    priorityTab = 1;

    cachedOrders = [];
    cachedPreOrders = [];

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

    setInMemoryToken(token){
        this.inMemoryToken = token
    }
    setPriorutyTab(number){
        this.priorityTab = number
    }

    setCachedOrders(array){
        this.cachedOrders = array
    }
    setCachedPreOrders(array){
        this.cachedPreOrders = array
    }

    async login(email, password){
        try {
            const res = await AuthService.login(email, password)
            if (res.status === 200){
              this.setInMemoryToken(res.data.accessToken)
              this.setUser(res.data.user);
              return res
            }
            
        } catch (e) {
            console.log(e);
        }
    }

    async logout(){
        try {
            await AuthService.logout();
            this.setInMemoryToken(null)
            this.setUser({});
        } catch (e) {
            console.log(e.response?.data?.message);
            
        }
    }

    async getNewToken(){
        return axios.get(`${API_URL}/refresh`, {withCredentials: true}).then(
            (r) => {
                this.setInMemoryToken(r.data.accessToken)
                return r.data.accessToken
            }
        );
    }

    async checkAuth() {
        this.setLoading(true);
        try {
            await axios.get(`${API_URL}/refresh`, {withCredentials: true}).then(
              (res) => {
                if (res.status === 200){
                  console.log(res)
                  this.setUser(res.data.user);
                  this.setInMemoryToken(res.data.accessToken)      
                  console.log('token validation complited')  
                }
              }
            )
        } catch (e) {
            console.log(e)
        } finally {
            this.setLoading(false);
            return this.inMemoryToken
        }
    }

    async uploadFile(acceptedFiles){
        const formData = new FormData()
        acceptedFiles.map(file => formData.append('files', file))
        const res = await axios.post(`${process.env.REACT_APP_API_URL}/s3/upload`, formData, {
            headers: {
              "Content-Type": "multipart/form-data",
            }
          });
        return res
    }

    async downloadFile(file){
        await fetch(`${process.env.REACT_APP_API_URL}/s3/get/${file.Key}`)
    }

    async deleteFile(key, deleteFileMutation){
        const res = await axios.get(`${process.env.REACT_APP_API_URL}/s3/delete/${key}`);

        if (res.status === 200){
            const hasuraRes = await deleteFileMutation({variables: {
                'key': key,
            }})
            console.log(hasuraRes.data)
        }
        // if (res.status != 200) console.log('error during deleting file from S3', res)
    }

    pageParams = [
        {
            'url' : '/reclamation',
            'icon': <UilWrench/>,
            'title': 'Рекламация',
        },
        {
            'url' : '/attendance',
            'icon': <UilConstructor/>,
            'title': 'Рабочее время',
        },
    ];

    getPageParams(url){
        const page = this.pageParams.find((el) => el.url === url)
        return page
    }

    preloader = <Pane display="flex" alignItems="center" justifyContent="center" height='75vh'><Spinner /></Pane>
}
