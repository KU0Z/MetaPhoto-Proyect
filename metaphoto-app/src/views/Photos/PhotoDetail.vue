<template>
  <div>
    <v-toolbar flat dark >

      
      
    </v-toolbar>
      <v-container v-if="show">
        <div class="text-center">
          <v-progress-circular

          size="100"
          color="primary"
          indeterminate
          ></v-progress-circular>
        </div>

      </v-container>
      
    <v-container v-if="!show" fluid>
      <v-row dense>
        <v-col
          cols="12"
          xs="12"
          sm="12"
          md="12"
          lg="12"
        >
          <v-card >
            <v-img
              :src="cards.url"
              class="white--text align-end"
              gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
              height="50vh"
            >
              
            </v-img>
            <v-tooltip bottom>
              <template v-slot:activator="{ on, attrs }">
                <v-card-title 
                v-bind="attrs"
                  v-on="on" 
                  class="headerClass" v-text="cards.title"></v-card-title>
              </template>
              <span>{{cards.title}}</span>
            </v-tooltip>
            
            
            <v-card-subtitle>

              <div > <strong>Album: </strong>{{cards.album.title}}</div>
              <div> <strong>User:</strong> {{cards.album.user.name}}</div>
              <div > <strong>#: </strong>{{cards.id}}</div>
              <div > <strong>#Album: </strong>{{cards.album.id}}</div>
            </v-card-subtitle>
            <div>
                <v-avatar
                  class="ma-3"
                  size="125"
                  rounded="0"
                >
                  <v-img :src="cards.thumbnailUrl"></v-img>
                </v-avatar>
                <v-divider></v-divider>
        
                <v-card-text class="text--primary">
                  <div> Username: {{cards.album.user.username}}</div>
                  <div> Username: {{cards.album.user.email}}</div>
                  <div> Phone: {{cards.album.user.phone}}</div>
                  <div> Website: {{cards.album.user.website}}</div>
                  <div> Company Name: {{cards.album.user.company.name}}</div>
                </v-card-text>
              </div>
            <v-card-actions>
              <v-spacer></v-spacer>
            </v-card-actions>
            
        

          </v-card>
        </v-col>

      </v-row>

    </v-container>                            
  </div>
</template>

<script>
  export default {
    props:{

    },
    data(){
      return {
        limit:25,
        offset:0,
        totalItems:1,
        page: 1,
        show: true,
        search: '',
        contries: [ "Guatemala","Alemania","Inglaterra","Irlanda"],
        types: [ "Lager","Ale","Rubia","Stout"],
        title: "officia porro iure quia iusto qui ipsa ut modi",
      type: 0,
        cards: { show:false ,price: 10, "id": 1,
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
      valid: true,
      name: '',
      nameRules: [
        //v => !!v || 'Title is required',
        v => (v || '').length  <= 255  || 'Name must be less than 255 characters',
      ],
      limitRules: [
        //v => !!v || 'Title is required',
        v => ((v )  > 0 )  || 'limit must be more than 0',
        v => ((v )  <= 500 )  || 'limit must be less than 5000',
      ],
      albumtitle : '',
      albumtitleRules: [
        //v => !!v || 'Name is required',
        v => (v || '').length  <= 255 || 'Album Title must be less than 255 characters',
      ],
      email: '',
      emailRules: [
        //v => !!v || 'E-mail is required',
        v => ( (v || '').length == 0 || /.+@.+\..+/.test(v))  || 'E-mail must be valid',
      ],
      select: null,
      items: [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
      ],
      id:0
      }
    },
    created() {
      console.log(this.$route.params.id)
      this.id=this.$route.params.id
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
        this.$refs.form.resetValidation()
        console.log(this.$refs.form)
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
        this.loadPhotos(self.name,self.albumtitle,self.email,self.offset,self.limit)
      },
      nextPage() {
        console.log('nextPage')
        console.log(this.page)
        
      },
      previousPage() {
        console.log('nextPage')
        console.log(this.page)
      },
      applyfilter() {
        let self=this
        self.offset=0
        this.loadPhotos(self.name,self.albumtitle,self.email,self.offset,self.limit)
      },
      resetfilter() {
        let self=this
        this.name = ""
        this.albumtitle = ""
        this.email = ""
        this.limit=25
        this.limit=25
        this.offset=0
        this.resetValidation()
        this.loadPhotos(self.name,self.albumtitle,self.email,self.offset,self.limit)
      },
      loadPhotos (title,albumTitle,albumUserEmail,offset,limit) {
        let params ={title:title,'album.title':albumTitle,'album.user.email':albumUserEmail,offset:offset,limit:limit }
        let self=this
        this.axios.get('photos/'+this.id,{ params })
          .then((res) => {            
              res.data.payload.show =false
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
        this.show= true
        let self=this
        this.loadPhotos(self.name,self.albumTitle,self.email,self.offset,self.limit)
        this.show= false

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