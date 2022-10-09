<template>
  <div>
    <v-app-bar
      app
      color="primary"
      dark
    >
    
    <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
     <v-spacer></v-spacer> <v-btn color="secondary" @click="logout()" >Sign Out</v-btn>
    </v-app-bar>
    <v-navigation-drawer
      v-model="drawer"
      app
    >
      <v-list dense>
        <v-list-item-group
          v-model="group"
          active-class="deep-purple--text text--accent-4"
        >
            <v-list-item
            v-for="item in items"
            :key="item.id"
            @click="$router.push (item.to)"
            link
            >
            <v-list-item-icon>
                <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-icon>

            <v-list-item-content>
                <v-list-item-title>{{ item.text }}</v-list-item-title>
            </v-list-item-content>
            </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>    
  </div>
</template>
<script>

        
    export default {    
      name: "app-header",    
      components:{
      },
      computed: {
      },
      methods: {
        logout: function() {
          this.$store.dispatch('LOGOUT')
          
        },
        viewAccount(){
          
        },
      },
      data() {  
        return {
          drawer: true,
          items: [
        { id:0, icon: 'mdi-contacts', text: 'Home' , to: '/'},
        { id:1, icon: 'mdi-content-copy', text: 'Catalogo' , to: '/photos' },
        { id:2, icon: 'mdi-content-copy', text: 'Pedidos' , to: '/login' }
      ]
        }  
      }    
    }
</script>
