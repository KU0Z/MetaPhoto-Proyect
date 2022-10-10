import Vue from 'vue'
import  VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import Login from '../views/Login/LoginView.vue'
import PhotoIndex from '../views/Photos/PhotoIndex.vue'
import RegisterIndex from '../views/Register/RegisterIndex.vue'
import NotFound from '../views/NotFound/404Index.vue'
Vue.use(VueRouter) 
const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/photos',
    name: 'Photos',
    component: PhotoIndex
  },
  {
    path: '/register',
    name: 'Register',
    component: RegisterIndex 
  },
  {
    path: '/*',
    name: 'NotFound',
    component: NotFound
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router
