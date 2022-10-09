<template>
  <v-app>
    <AppHeader v-if='!showMenu' ></AppHeader>
    <v-content >
      <router-view/>
    </v-content>
    <AppFooter v-if='!showMenu'/>
  </v-app>
</template>

<script>
import AppHeader from '@/components/base/appHeader.vue'
import AppFooter from '@/components/base/appFooter.vue'
//import Login from '@/views/Login/Login.vue'
export default {
  name: 'App',
  components: {
    AppHeader,
    AppFooter
    //Login
  },
      computed: {
      showMenu() {
        return (this.$route.name === 'Login') || (this.$route.name === 'Register');
      } 
    },

  data: () => ({
    drawer: false,
    auticated: false,
    //
  }),
}
</script>