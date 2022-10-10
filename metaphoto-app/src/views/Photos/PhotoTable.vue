<template>
  <div>
    <v-toolbar flat dark >
      <v-toolbar-title>  {{ dataTitle }}</v-toolbar-title>     
      <v-divider
        class="mx-2"
        inset
        vertical
      ></v-divider>
      <v-spacer></v-spacer>
      <v-btn color="success" @click="show = !show" >Filter</v-btn>
      
      
    </v-toolbar>
    <v-container v-show="show" fluid>
        <v-form
        ref="form"
        v-model="valid"
        lazy-validation
      >
      <v-row>
        <v-col
          cols="12"
          md="4"
        >
        <v-text-field
          v-model="name"
          :counter="255"
          :rules="nameRules"
          label="Title"
          
        ></v-text-field>
        </v-col>
        <v-col
          cols="12"
          md="4"
        >
        <v-text-field
          v-model="albumtitle"
          :rules="albumtitleRules"
          label="Album Title"
          
        ></v-text-field>
        </v-col>
        <v-col
          cols="12"
          md="4"
        >
        <v-text-field
          v-model="email"
          :rules="emailRules"
          label="E-mail"
          
        ></v-text-field>
        </v-col>

      </v-row>
      <v-row>
        <v-col
          cols="12"
          md="4"
        >
        <v-text-field
          v-model="name"
          :counter="255"
          :rules="nameRules"
          label="Title"
          
        ></v-text-field>
        </v-col>
        <v-col
          cols="12"
          md="4"
        >
        <v-btn
          :disabled="!valid"
          color="success"
          class="mr-4"
          @click="validate"
        >
        Apply Filter
        </v-btn>
        </v-col>
        <v-col
          cols="12"
          md="4"
        >
        <v-btn
          color="error"
          class="mr-4"
          @click="reset"
        >
          Reset Filter
        </v-btn>
        </v-col>

      </v-row>
      
        

        
        

        <v-select
          v-model="select"
          :items="items"
          :rules="[v => !!v || 'Item is required']"
          label="Item"
          required
        ></v-select>

        


      </v-form>
      
      </v-container>
    <v-container fluid>
      <v-row dense>
        <v-col
          v-for="(item , index) in cards"
          :key="index"
          cols="12"
          xs="12"
          sm="6"
          md="4"
          lg="3"
        >
          <v-card >
            <v-img
              :src="item.url"
              class="white--text align-end"
              gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
              height="200px"
            >
              
            </v-img>
            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-card-title 
                v-bind="attrs"
                  v-on="on" 
                  class="headerClass" v-text="item.title"></v-card-title>
              </template>
              <span>{{item.title}}</span>
            </v-tooltip>
            
            
            <v-card-subtitle>

              <div > <strong>Album: </strong>{{item.album.title}}</div>
              <div> <strong>User:</strong> {{item.album.user.name}}</div>
              <div > <strong>#: </strong>{{item.id}}</div>
            </v-card-subtitle>
            <v-card-actions>
              <v-btn
                color="primary"
                text
                @click="showdetail(index)"
              >
                Detalle Usuario
              </v-btn>
        
              <v-spacer></v-spacer>
        
              <v-btn
                icon
                @click="item.show = !item.show"
              >
                <v-icon>{{ item.show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
              </v-btn>
            </v-card-actions>
        
            <v-expand-transition>
              <div v-show="item.show">
                <v-avatar
                  class="ma-3"
                  size="125"
                  rounded="0"
                >
                  <v-img :src="item.thumbnailUrl"></v-img>
                </v-avatar>
                <v-divider></v-divider>
        
                <v-card-text class="text--primary">
                  <div> Username: {{item.album.user.username}}</div>
                  <div> Username: {{item.album.user.email}}</div>
                  <div> Phone: {{item.album.user.phone}}</div>
                  <div> Website: {{item.album.user.website}}</div>
                  <div> Company Name: {{item.album.user.company.name}}</div>
                </v-card-text>
              </div>
            </v-expand-transition>

          </v-card>
        </v-col>

      </v-row>
      <div class="text-center">
          <v-container>
            <v-row justify="center">
              <v-col cols="8">
                <v-container class="max-width">
                  <v-pagination
                    v-model="page"
                    class="my-4"
                    :length="totalItems"
                    @next="nextPage()"
                    @previous="previousPage()"
                    @input="chagePage(page)"
                  ></v-pagination>
                </v-container>
              </v-col>
            </v-row>
          </v-container>
        </div>
    </v-container>                            
  </div>
</template>

<script>
  export default {
    props:{
      dataTitle: String,

    },
    data(){
      return {
        limit:25,
        offset:0,
        totalItems:1,
        page: 1,
        show: false,
        search: '',
        contries: [ "Guatemala","Alemania","Inglaterra","Irlanda"],
        types: [ "Lager","Ale","Rubia","Stout"],
      type: 0,
        cards: [
        { show:false ,price: 10, "id": 1,
            "title": "officia porro iure quia iusto qui ipsa ut modi",
            "url": "https://via.placeholder.com/600/24f355",
            "thumbnailUrl": "https://via.placeholder.com/150/24f355",
            "album": {
                "id": 1,
                "title": "quidem molestiae enim",
                "user": {
                    "id": 1,
                    "name": "Leanne Graham",
                    "username": "Bret",
                    "email": "Sincere@april.biz",
                    "address": {
                        "street": "Kulas Light",
                        "suite": "Apt. 556",
                        "city": "Gwenborough",
                        "zipcode": "92998-3874",
                        "geo": {
                            "lat": "-37.3159",
                            "lng": "81.1496"
                        }
                    },
                    "phone": "1-770-736-8031 x56442",
                    "website": "hildegard.org",
                    "company": {
                        "name": "Romaguera-Crona",
                        "catchPhrase": "Multi-layered client-server neural-net",
                        "bs": "harness real-time e-markets"
                    }
                }
            } },
        { show:false ,price: 35, "id": 2,
            "title": "officia porro iure quia iusto qui ipsa ut modi",
            "url": "https://via.placeholder.com/600/24f355",
            "thumbnailUrl": "https://via.placeholder.com/150/24f355",
            "album": {
                "id": 1,
                "title": "quidem molestiae enim",
                "user": {
                    "id": 1,
                    "name": "Leanne Graham",
                    "username": "Bret",
                    "email": "Sincere@april.biz",
                    "address": {
                        "street": "Kulas Light",
                        "suite": "Apt. 556",
                        "city": "Gwenborough",
                        "zipcode": "92998-3874",
                        "geo": {
                            "lat": "-37.3159",
                            "lng": "81.1496"
                        }
                    },
                    "phone": "1-770-736-8031 x56442",
                    "website": "hildegard.org",
                    "company": {
                        "name": "Romaguera-Crona",
                        "catchPhrase": "Multi-layered client-server neural-net",
                        "bs": "harness real-time e-markets"
                    }
                }
            } },
        { show:false ,price: 33, "id": 3,
            "title": "officia porro iure quia iusto qui ipsa ut modi",
            "url": "https://via.placeholder.com/600/24f355",
            "thumbnailUrl": "https://via.placeholder.com/150/24f355",
            "album": {
                "id": 1,
                "title": "quidem molestiae enim",
                "user": {
                    "id": 1,
                    "name": "Leanne Graham",
                    "username": "Bret",
                    "email": "Sincere@april.biz",
                    "address": {
                        "street": "Kulas Light",
                        "suite": "Apt. 556",
                        "city": "Gwenborough",
                        "zipcode": "92998-3874",
                        "geo": {
                            "lat": "-37.3159",
                            "lng": "81.1496"
                        }
                    },
                    "phone": "1-770-736-8031 x56442",
                    "website": "hildegard.org",
                    "company": {
                        "name": "Romaguera-Crona",
                        "catchPhrase": "Multi-layered client-server neural-net",
                        "bs": "harness real-time e-markets"
                    }
                }
            } },
        { show:false ,price: 25, "id": 4,
            "title": "officia porro iure quia iusto qui ipsa ut modi",
            "url": "https://via.placeholder.com/600/24f355",
            "thumbnailUrl": "https://via.placeholder.com/150/24f355",
            "album": {
                "id": 1,
                "title": "quidem molestiae enim",
                "user": {
                    "id": 1,
                    "name": "Leanne Graham",
                    "username": "Bret",
                    "email": "Sincere@april.biz",
                    "address": {
                        "street": "Kulas Light",
                        "suite": "Apt. 556",
                        "city": "Gwenborough",
                        "zipcode": "92998-3874",
                        "geo": {
                            "lat": "-37.3159",
                            "lng": "81.1496"
                        }
                    },
                    "phone": "1-770-736-8031 x56442",
                    "website": "hildegard.org",
                    "company": {
                        "name": "Romaguera-Crona",
                        "catchPhrase": "Multi-layered client-server neural-net",
                        "bs": "harness real-time e-markets"
                    }
                }
            } },
      ],
      valid: true,
      name: '',
      nameRules: [
        v => !!v || 'Title is required',
        v => (v && v.length <= 255) || 'Name must be less than 255 characters',
      ],
      albumtitle : '',
      albumtitleRules: [
        v => !!v || 'Name is required',
        v => (v && v.length <= 255) || 'Name must be less than 255 characters',
      ],
      email: '',
      emailRules: [
        v => !!v || 'E-mail is required',
        v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      ],
      select: null,
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
      }
    },
    created() {
      this.loadBeers()
      


    },
    methods: {
        editItem (item) {
        this.$router.push('/beer/edit/'+item );
      },
      goToForm(){
        this.$router.push( '/beer/add');
      },
      showdetail(index){
        console.log(this.cards)
        console.log(index)
        //card.show= !card.show
        console.log(this.cards[index].show)
        this.cards[index].show=!this.cards[index].show
      },
      deleteBeers(id){
        //let self=this
        this.axios.delete('beers/'+id)
          .then((res) => {            

              console.log(res)
              this.loadBeers()
             
          })
          .catch((err) => {
             console.error(err)
  
          })

      },
      validate () {
        this.$refs.form.validate()
      },
      reset () {
        this.$refs.form.reset()
      },
      resetValidation () {
        this.$refs.form.resetValidation()
      },
      chagePage(number) {
        console.log('chagePage')
        console.log(number)
        console.log(this.page)
        this.offset=(this.limit*(this.page-1))
        let self=this
        this.loadPhotos(self.name,self.albumTitle,self.email,self.offset,self.limit)
      },
      nextPage() {
        console.log('nextPage')
        console.log(this.page)
        
      },
      previousPage() {
        console.log('nextPage')
        console.log(this.page)
      },
      loadPhotos (title,albumTitle,albumUserEmail,offset,limit) {
        let params ={title:title,albumTitle:albumTitle,albumUserEmail:albumUserEmail,offset:offset,limit:limit }
        let self=this
        this.axios.get('photos',{ params })
          .then((res) => {            
              res.data.payload.map((photos) => {
                    photos.show =false
                    return {  photos
                    }
                    })
              console.log(res.data)
              self.cards=res.data.payload
              self.totalItems=res.data.totalPages
              //self.contries = JSON.parse(self.contries)
              //self.types = JSON.parse(self.types)
             
          })
          .catch((err) => {
             console.error(err)
  
          })
      },
      loadBeers(){
        let self=this
        this.loadPhotos(self.name,self.albumTitle,self.email,self.offset,self.limit)
        // this.axios.get('photos')
        //   .then((res) => {            
        //       res.data.payload.map((photos) => {
        //             photos.show =false
        //             return {  photos
        //             }
        //             })
        //       console.log(res.data)
        //       self.cards=res.data.payload
        //       self.totalItems=res.data.totalPages
        //       //self.contries = JSON.parse(self.contries)
        //       //self.types = JSON.parse(self.types)
             
        //   })
        //   .catch((err) => {
        //      console.error(err)
  
        //   })

      }
      
    }
  }
</script>

<style >
.headerClass{
    white-space: nowrap ;
    word-break: normal;
    overflow: hidden ;
    text-overflow: ellipsis;
}
.v-card__title{
  padding-bottom: 0;
  padding-top: 0;
}
.v-card__subtitle{
  padding-bottom: 0;
  padding-top: 18px !important;
}
</style>