<template>
<div>
    <v-bottom-navigation
    background-color="primary"
    dark
    shift
  >
  <v-spacer></v-spacer>
    <v-btn>
      <span class="white--text">&copy; {{ new Date().getFullYear() }}</span>

      <v-icon>mdi-image</v-icon>
    </v-btn>
  </v-bottom-navigation>
</div>
</template>
<script>   
    export default {    
      name: "app-footer",    
      computed: {
      },
      methods: {
        logout: function() {
          
        },
        viewAccount(){
          
        },
      },
      data() {  
        return {
          icons: [
            'mdi-facebook',
            'mdi-twitter',
            'mdi-linkedin',
            'mdi-instagram',
        ]
        }  
      }    
    }
</script>


