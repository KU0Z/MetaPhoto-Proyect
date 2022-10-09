<template>
  <v-container fluid fill-height ma-0 pa-0>
    <v-layout row fill-height>
      <v-flex hidden-sm-and-down md8 lg8 xl8 align-center justify-center fill-height >
           <v-img src="https://picsum.photos/510/300?random" style="height:100vh !important"></v-img>
      </v-flex> 
      <v-flex xs12 sm12 md4 lg4 xl4 fill-height>
        <v-card class="pa-6 fill-height">
          <div class="text-right">
            <div class="display-2" style="margin: 18vh auto 0 auto;">Log In</div>                                  
          </div>          
          <v-card-text >
          
                <v-form ref="form" v-model="valid">
                    <v-alert
                      :value="error"
                      type="error"
                      class="mb-2"
                    >
                      Ocurrio un error con la authenticacion prube otra vez 
                    </v-alert>
                    <v-text-field
                        @keyup.enter ="reset()"
                        v-model="email"
                        label="Correo Electronico"
                        name="Correo"
                        prepend-icon="mdi-email"
                        :rules="emailRules"
                        type="text"
                        required
                    ></v-text-field>

                    <v-text-field
                    v-model="password"
                        id="password"
                        label="Password"
                        name="password"
                        :rules="passwordRules"
                        prepend-icon="mdi-lock"
                        type="password"
                        required
                        @keyup.enter="login()"
                    ></v-text-field>
                    <v-btn block color="primary" :disabled="!valid"  @click="login()" >Acceso</v-btn>
                </v-form>
          </v-card-text>
          <v-card-actions>
            
            <div>
                
            </div>
            
          </v-card-actions>
          <v-card-text >
            <router-link to="/register" class="btn btn-link">Register</router-link>
          </v-card-text>
        </v-card>        
      </v-flex>
                     
    </v-layout>
  </v-container>
</template>
<script>
  export default {
    data () {
      return {
      valid: true,
      maintenance: false,
      process: false,      
      drawer: null,
      name: '',
      lastName: '',
      userName: '',
      nameRules: [
        v => !!v || 'Name is required',
        v => (v && v.length <= 20) || 'Name must be less than 10 characters',
      ],
      emailRules: [
        v => !!v || 'Correo requerido',
        v => /.+@.+/.test(v) || 'El correo debe ser válido'
      ],
      passwordRules: [
        v => !!v || 'Contraseña requerida'
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
       reset () {
        this.error=false
      },
       validate () {
        this.$refs.form.validate()
      },
     login() {
      //  firebase
      // .auth()
      // .signInWithEmailAndPassword(this.email, this.password)
      // .then(data => {
      //   console.log(data.user)
      //   this.$store.dispatch('AUTH',data.user)
      //   self.error=false
      //   this.$router.replace({ name: "Home" });
      // })
      // .catch(err => {
      //   this.error = err.message;
      //});

        /*let endpoint = 'http://localhost:8080/account/authentication'
        let payload = {
          
              UserName :this.userName,
              Password :this.password
          
        }
        let options = {
            headers: { 

                'content-type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
          };

        let self=this
        self.error=false
        this.axios.post('auth/account/authentication',payload)
          .then((res) => {  
            this.$store.dispatch('TOKEN',res.data)          
              self.axios.get('auth/user?userId='+res.data.UserId)
                .then((res) => {
                  console.log('yes')
                    console.log(res)
                    self.error=false
                    this.$store.dispatch('AUTH',res.data)
                  
                })
                .catch((err) => {
                  console.log('yes')
                  self.error=true
                  //console.error(err)
        
                })
              //this.$store.dispatch('AUTH',res.data.UserId)
             
          })
          .catch((err) => {
             self.error=true
             console.error(err)
             console.log('no')
  
          })*/
      }
    }
  }
</script>