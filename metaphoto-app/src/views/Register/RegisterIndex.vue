<template>
    <v-container fluid fill-height ma-0 pa-0>
      <v-layout row fill-height>
        <v-flex xs12 sm12 md4 lg4 xl4 fill-height>
          <v-card class="pa-6 fill-height">
            <div class="text-right">
              <div class="display-2" style="margin: 18vh auto 0 auto;">Register</div>                                  
            </div>          
            <v-card-text>
                  <v-form>
                      <v-text-field
                          v-model="email"
                          :rules="emailRules"
                          label="Correo electronico"
                          name="Correo"
                          prepend-icon="mdi-account"
                          type="text"
                      ></v-text-field>
                      <v-text-field
                          v-model="name"
                          :rules="nameRules"
                          label="Nombre"
                          name="Nobre"
                          prepend-icon="mdi-account"
                          type="text"
                      ></v-text-field>
                      <v-text-field
                        v-model="password"
                          id="password"
                          label="Password"
                          name="password"
                          prepend-icon="mdi-lock"
                          type="password"
                      ></v-text-field>
                  </v-form>
            </v-card-text>
            <v-card-actions>
              <v-btn block color="primary" @click="register()">Acceso</v-btn>
              
            </v-card-actions>
            <v-card-text >
              <router-link to="/login" class="btn btn-link">Cancel</router-link>
            </v-card-text>
          </v-card>        
        </v-flex>
        <v-flex hidden-sm-and-down md8 lg8 xl8 align-center justify-center fill-height >
             <v-img src="https://picsum.photos/510/300?random" style="height:100vh !important"></v-img>
        </v-flex>                
      </v-layout>
    </v-container>
  </template>
  <script>
    export default {
      data () {
        return {
        maintenance: false,
        process: false,      
        drawer: null,
        name: '',
        userName: '',
        nameRules: [
          v => !!v || 'Name is required',
          v => (v && v.length <= 10) || 'Name must be less than 10 characters',
        ],
        emailRules: [
          v => !!v || 'Correo requerido',
          v => /.+@.+/.test(v) || 'El correo debe ser válido'
        ],
        email: "",
        password: "",
        error: false,
        wallpaper:"",
        wallpaperVideo: null,
        wallpaperReady: false
        }
      },
      created: function () {
  
    },
    mounted:function (){
    },
      methods: {
       register() {
         /*
          let endpoint = 'http://localhost:8080/auth/account'
          let payload = {
            User: { 
              "Name":this.name,
              "LastName":this.lastName
              },
            Credentials:
            {
                "UserName":this.userName,
                "Password":this.password
            },
          }
          let options = {
              headers: { 
  
                  'content-type': 'application/json',
                  'Access-Control-Allow-Origin': '*'
              },
            };
          return this.axios.post('auth/account', payload,options)
            .then((res) => {
              return console.log(res)
            })
            .catch((err) => {
              console.error(err)
              return console.error(err)
            })*/
        //   firebase.auth().createUserWithEmailAndPassword(this.email, this.password)
        //   .then(data => {
        //      data.user.updateProfile({
        //         displayName: this.name
        //       })
        //       .then(() => {
        //         this.$router.replace({ name: "Login" });
        //       });
        //   })
        //   .catch(err => {
        //     console.log(err)
        //     this.error = err.message;
        //   });
        }
      }
    }
  </script> 