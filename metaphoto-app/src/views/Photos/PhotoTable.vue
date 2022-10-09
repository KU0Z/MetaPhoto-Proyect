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
      <v-btn color="success" @click="goToForm()" >create</v-btn>
      
    </v-toolbar>
    <v-container fluid>
      <v-row dense>
        <v-col
          v-for="card in cards"
          :key="card.name"
          cols="3"
        >
          <v-card>
            <v-img
              :src="card.url"
              class="white--text align-end"
              gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
              height="200px"
            >
              
            </v-img>
            <v-card-title v-text="card.title"></v-card-title>
            
            <v-avatar
                  class="ma-3"
                  size="125"
                  rounded="0"
                >
                  <v-img :src="card.thumbnailUrl"></v-img>
                </v-avatar>
                <v-card-subtitle>
            Album: {{card.album.title}}
            </v-card-subtitle>
            <v-card-subtitle>
            Usuario: {{card.album.user.name}}
            </v-card-subtitle>
            <v-card-actions>
              <v-btn
                color="orange lighten-2"
                text
              >
                Detalle Usuario
              </v-btn>
        
              <v-spacer></v-spacer>
        
              <v-btn
                icon
                @click="card.show = !card.show"
              >
                <v-icon>{{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
              </v-btn>
            </v-card-actions>
        
            <v-expand-transition>
              <div v-show="card.show">
                <v-divider></v-divider>
        
                <v-card-text>
                  I'm a thing. But, like most politicians, he promised more than he could deliver. You won't have time for sleeping, soldier, not with all the bed making you'll be doing. Then we'll go with that data file! Hey, you add a one and two zeros to that or we walk! You're going to do his laundry? I've got to find a way to escape.
                </v-card-text>
              </div>
            </v-expand-transition>

          </v-card>
        </v-col>
      </v-row>
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
        search: '',
        contries: [ "Guatemala","Alemania","Inglaterra","Irlanda"],
        types: [ "Lager","Ale","Rubia","Stout"],
      type: 0,
        cards: [
        { type:1 ,price: 10, "id": 1,
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
        { type:1 ,price: 35, "id": 2,
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
        { type:1 ,price: 33, "id": 3,
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
        { type:1 ,price: 25, "id": 4,
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
      }
    },
    created() {
      //this.loadBeers()
      this.cards.map((card) => {
                    card.show =false
                    return {card
                    }
                    })
                    console.log(this.cards)


    },
    methods: {
        editItem (item) {
        this.$router.push('/beer/edit/'+item );
      },
      goToForm(){
        this.$router.push( '/beer/add');
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
      loadBeers(){
        // let self=this
        // this.axios.get('beers')
        //   .then((res) => {            
              
        //       console.log(res)
        //       self.cards=res.data
        //       self.contries = JSON.parse(self.contries)
        //       self.types = JSON.parse(self.types)
             
        //   })
        //   .catch((err) => {
        //      console.error(err)
  
        //   })

      }
      
    }
  }
</script>

<style >
.v-card__title{
  padding-bottom: 0;
  padding-top: 0;
}
.v-card__subtitle{
  padding-bottom: 0;
  padding-top: 18px !important;
}
</style>