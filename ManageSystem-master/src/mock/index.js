import Mock from 'mockjs'

import Login from './login.js'
import TempList from './temp'


// 设置mock的延时
Mock.setup({
  timeout: '200-2000'
})

const baseUrl = 'http://127.0.0.1'
// 登录数据的拦截
Mock.mock(baseUrl + '/public/login', 'post', Login.getToken)
Mock.mock('http://localhost/user/info', 'post', Login.getUserInfo)
Mock.mock(baseUrl + '/menu/tree', 'get', Login.getMenuInfo)

Mock.mock(baseUrl + '/getTempList', 'post', TempList.getTempList)
