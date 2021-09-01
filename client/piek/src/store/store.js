
import {makeAutoObservable} from 'mobx';
import {Pane, Spinner} from 'evergreen-ui';
import AuthService from '../services/AuthService';
import axios from 'axios';
import { API_URL } from '../http';
import { UilSortAmountDown, UilEnvelopeInfo, UilWrench, UilConstructor} from '@iconscout/react-unicons';

export default class Store {
    user = {};
    isAuth = false;
    isLoading = false;
    inMemoryToken = undefined;

    priorityTab = 0;
    showPreOrders = false;

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

    setShowPreOrders(bool){
        this.showPreOrders = bool
    }
    
    async login(email, password){
        try {
            const response = await AuthService.login(email, password);
            // localStorage.setItem('token', response.data.accessToken);

            this.setInMemoryToken(response.data.accessToken)
            this.setUser(response.data.user);
            this.setAuth(true);
            // window.location.href='/';
            console.log('store', this.inMemoryToken)
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
        } catch (e) {
            console.log(e.response?.data?.message);
            
        }
    }

    async checkAuth() {
        this.setLoading(true);
        try {
            console.log('check auth request')
            const response = await axios.get(`${API_URL}/refresh`, {withCredentials: true});
            this.setInMemoryToken(response.data.accessToken)

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
        const res = await fetch(`${process.env.REACT_APP_API_URL}/s3/get/${file.Key}`)

        // if (res.status == 200 ){
        //     const blob = await res.blob()
        //     const downloadURL = window.URL.createObjectURL(blob)
        //     const link = document.createElement('a')
        //     link.href = downloadURL
        //     link.download = file.FileName
        //     document.body.appendChild(link)
        //     link.click()
        //     link.remove()
        // }
    }

    async deleteFile(key, deleteFileMutation){
        const res = await axios.get(`${process.env.REACT_APP_API_URL}/s3/delete/${key}`);

        if (res.status == 200){
            const hasuraRes = await deleteFileMutation({variables: {
                'key': key,
            }})
            console.log(hasuraRes.data)
        }
        // if (res.status != 200) console.log('error during deleting file from S3', res)
    }

    pageParams = [
        {
            'url' : '/',
            'icon': <UilSortAmountDown/>,
            'title': 'Очередность выполнения',
        },
        {
            'url' : '/recently',
            'icon': <UilEnvelopeInfo/>,
            'title': 'Недавние',
        },
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
