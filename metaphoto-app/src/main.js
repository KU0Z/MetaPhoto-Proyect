import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'

console.log(process.env.VUE_APP_URL)
console.log(process.env.VUE_APP_TOKEN_SECRET)
console.log(process.env.NODE_ENV)
Vue.config.productionTip = false
const base = axios.create({
  baseURL: process.env.VUE_APP_URL,
  headers: {
    'Content-Type': 'application/json'
	}
})
Vue.use(VueAxios, base)
new Vue({
  router,
  vuetify,
  render: h => h(App)
}).$mount('#app')

