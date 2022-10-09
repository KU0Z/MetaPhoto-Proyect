<template>
<div>
    <v-toolbar  flat dark >
    <v-toolbar-title>  {{title}} </v-toolbar-title>     
      <v-divider
        class="mx-2"
        inset
        vertical
      ></v-divider>
      <v-spacer></v-spacer>
      <v-btn color="grey" @click="goToForm()" >cancel</v-btn>
      
    </v-toolbar>
    <v-container>
      
  <v-form
    ref="form"
    v-model="valid"
  >
  <v-layout align-center row wrap>
    <v-flex xs12 sm12 md12>
      <v-text-field
        v-model="name"
        :rules="nameRules"
        label="Nombre"
        required
      ></v-text-field>
    </v-flex >
    <v-flex xs12 sm12 md12>
        <v-text-field
          v-model="description"
          :rules="nameRules"
          label="Descripción"
          required
        ></v-text-field>
    </v-flex >

    <v-flex xs12 sm12 md4>
      <v-text-field
      type="number"
      v-model.number="email"
      :rules="emailRules"
      label="Price"
      prefix="Q"
      @input="handleInput"
    ></v-text-field>
    </v-flex >
    <v-flex xs12 sm12 md4>
      
      <v-select
        v-model="contry"
        :items="contries"
        :rules="emailRules"
        item-text="name"
        item-value="value"
        label="Pais"
        >
      </v-select>
    </v-flex >
    <v-flex xs12 sm12 md4>
          <v-select
          :rules="emailRules"
          v-model="type"
          :items="types"
          item-text="name"
          item-value="value"
          label="Tipo"
          required
        ></v-select>
    </v-flex >
    <v-flex xs12 sm12 md12>
        <v-file-input  :rules="imRules"  multiple label="File input" @change="previewImage" accept="image/*">
        </v-file-input>

    </v-flex >
    <v-flex v-if="imageData!=null" xs12 sm12 md12>
          <div>
          <p>Progreso: {{uploadValue.toFixed()+"%"}}
          <v-progress-linear v-if="cargando" color="green" height="35" :value="uploadValue"></v-progress-linear> </p>
          </div>
    </v-flex >

  
    <v-btn
      :disabled="!valid"
      color="success"
      class="mr-4"
      @click="send"
    >
      Send
    </v-btn>

    <v-btn
      color="grey"
      class="mr-4"
      @click="reset"
    >
      Reset Form
    </v-btn>
    <img v-if="picture!=null" :src="picture"  class="preview" style="width: 15% !important;" >

  </v-layout>
    
  </v-form>
</v-container>
</div>

</template>
<script>
  import firebase from 'firebase';
  import axios from'axios'  
  export default {
    props: ['idBeer'],
    data: () => ({
      title: "cerveza" ,         
      analizar:false,
      terminado:false,
      cargando:true,
      imageData: null,
      filesimage: null,
      picture: null,
      uploadValue: 0,
      previousPrice:null,
      name: '',
      nameimage: '',
      description: '',
      contry: 0,
      datas: [],
      contries: [{ name: 'Guatemala', value: 1 }, 
      { name: 'Alemania', value: 2 },
      { name: 'Inglaterra', value: 3 }, 
      { name: 'Irlanda', value: 4 },],
      type: 0,
      types: [{ name: 'Lager', value: 1 }, 
      { name: 'Ale', value: 2 },
      { name: 'Rubia', value: 3 }, 
      { name: 'Stout ', value: 4 },],
       desRules: [
        v => !!v || 'La Descripción  es requerida',
        v => (v && v.length >= 10) || 'Name must be less than 10 characters',
      ],
      nameRules: [
        v => !!v || 'El nombre es requerido',
        v => (v && v.length >= 3) || 'Name must be less than 10 characters',
      ],
      email: '',
      emailRules: [
        v => !!v || 'El tipo es requerido'
      ],
      typeRules: [
        v => !!v || 'El tipo es requerido'
      ],
      countrilRules: [
        v => !!v || 'El pais es requerido'
      ],
      imRules: [
        v => !!v || 'Agregue una imagen'
      ],
      select: null,
      items1: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
      checkbox: false,
      valid: false,
    }),
      created() {        
        //this.readNetworks()
        //this.fetchProducts()
        //this.fetchTarget()
        if (!!this.idBeer)
        {
          this.title =  "Editar cerveza" 
          this.readbeerId()

        }
        else
        {
          this.title = "Cerveza Nueva"          
        }        
      },
      watch: {     }, 
    computed: {
     validat () {
          //this.$refs.form.validate()


        },
     /* valide: function() {
            //console.log(this.$refs.form.validate())
                if ( this.$refs.form.validate() && (this.name!='')){
                  this.valid=true
                  return this.true

                }
                else{
                  this.valid=false
                  return this.false
                }
              }, /** */
      },
      methods: {
      readbeerId(){
              var self = this
      this.axios.get('beers/'+this.idBeer)
      .then(function(r){
        self.datas = r.data
        console.log(r.data)
        console.log( self.datas )
        self.name=self.datas.name ,
        self.description=self.datas.description,
        self.picture=self.datas.image,
        self.email=self.datas.price.$numberDecimal,
        self.type=self.datas.type,
        self.contry=self.datas.country
        
      })
      .catch(function(r){
        self.data = []
      })

      },
      handleInput (e) {
      let stringValue = e.toString()
      let regex = /^\d*(\.\d{1,2})?$/
      if(!stringValue.match(regex) && this.email!== '') {
        this.email= this.previousPrice
      }
      this.previousPrice = this.email
    },
      previewImage(event) {
      this.uploadValue=0;
      this.picture=null;
      this.imageData = event[0];

      this.onUpload()
    },
    sendSong(name) {
        let payload = {
          "name": name,
          "id": this.id
        }
        let options = {
            headers: { 

                'Content-type': 'application/json',
                "Access-Control-Allow-Headers":"*"
            },
          };
        return axios.post('https://us-central1-calcium-doodad-288418.cloudfunctions.net/testPost3', payload,options)
          .then((res) => {
            this.picture = "https://storage.googleapis.com/calcium-doodad-288418.appspot.com/urr/ima/"+res.data.filename
            this.prediction=res.data.prediction
            this.analizar=false
            this.terminado=true
            if (typeof res.data.filename === 'undefined') {
              this.picture = "https://blogs.uladech.edu.pe/pastillasgerenciales/wp-content/uploads/sites/18/2016/08/error-code-18.jpeg"
           // color is undefined
           }
            //return console.log(res)
          })
          .catch((err) => {
            //console.error(err)
            return console.error(err)
            
          })
      
    },

    onUpload(){
      this.terminado=false
      this.cargando=true
      this.picture=null;
      this.nameimage=Date.now()+this.imageData.name
      const storageRef=firebase.storage().ref(`beers/${this.nameimage}`).put(this.imageData);
      storageRef.on(`state_changed`,snapshot=>{
        this.uploadValue = (snapshot.bytesTransferred/snapshot.totalBytes)*100;
      }, error=>{console.log(error.message)},
      ()=>{this.uploadValue=100;
      this.analizar=true
      this.cargando=false
        storageRef.snapshot.ref.getDownloadURL().then((url)=>{
          //this.sendSong(this.name);
          this.picture =url;
        });
      }
      );
    },
    edit(id) {
        this.$router.push({
                path: '/beer/edit/' + id
            });

        },
      send () {
        //this.fetchTarget()

        this.$refs.form.validate() 
        if(this.$refs.form.validate()&&this.picture!=null){
          if (!!this.idBeer)
          {
                   let payload = {
                    "name": this.name,
                    "description" :this.description,
                    "image":this.picture,
                    "price": this.email,
                    "type": this.type,
                    "country": this.contry
                }
              let options = {
                  headers: { 

                      'Content-type': 'application/json'
                  },
                };
                let self=this
              axios.put('https://6nlk8s2xu7.execute-api.us-west-1.amazonaws.com/dev/api/v1/beers/'+this.idBeer, payload,options)
            .then(function(r){

              self.$router.push({ name: 'Home' });
              
            })
            .catch(function(r){
              self.recommendation = []
            })        
        }
          else
          {
                    let payload = {
                    "name": this.name,
                    "description" :this.description,
                    "image":this.picture,
                    "price": this.email,
                    "type": this.type,
                    "country": this.contry
                }
              let options = {
                  headers: { 

                      'Content-type': 'application/json'
                  },
                };
                let self=this
              axios.post(' https://6nlk8s2xu7.execute-api.us-west-1.amazonaws.com/dev/api/v1/beers', payload,options)
            .then(function(r){

              self.$router.push({ name: 'Home' });
              
            })
            .catch(function(r){
              self.recommendation = []
            })        
                }

        
        }
        
        
      },
      reset () {
        this.$refs.form.reset()
      },
      resetValidation () {
        this.$refs.form.resetValidation()
      },
    },
  }
</script>