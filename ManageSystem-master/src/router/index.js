import Vue from 'vue'
import Router from 'vue-router'

import Login from 'views/login/Login'

import tempDesign from '../components/form/tempDesign'

import Layout from '@/layout/index' 

Vue.use(Router)

const routes = [
    {
        path: '',
        redirect: '/login'
    },
    {
        path: '/login',
        component: Login
    },
    {
        path: '/home',
        component: Layout,
        redirect: '/business',
        children: [
            {
                path: '/user',
                component: () => import('views/base/user')
            },
            {
                path: '/role',
                component: () => import('views/base/role')
            },
            {
                path: '/menu',
                component: () => import('views/base/menu')
            },
            {
                path: '/dict',
                component: () => import('views/base/dict')
            },
            {
                path: '/business',
                component: () => import('views/series/business')
            },
            {
                path: '/template',
                component: () => import('views/series/temp')
            },
            {
                path: '/archives',
                component: () => import('views/series/archives')
            },
            {
                path: '/account',
                component: () => import('views/series/account')
            }
        ]
    },
    {
        path: '/tempDesign',
        component: tempDesign
    }
    


]

const router = new Router({
    routes,
    mode: 'history'
})

export default router