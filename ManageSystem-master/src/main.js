import Vue from 'vue'
import App from './App.vue'
import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
import './assets/font/iconfont.css'
import router from './router/index'
import store from './store'
// import asyncRoutes from './router/async'
// import '@/mock'

Vue.use(Element)

Vue.config.productionTip = false

import KFormDesign from 'k-form-design'
import 'k-form-design/lib/k-form-design.css'
Vue.use(KFormDesign)

// Vue.prototype.$store = store

new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')
