<template>
  <div>
    <table-Photos :dataTitle="title"  >
    </table-Photos>
  </div>
</template>

<script>  
 // import axios from'axios'  
  import tablePhotos from '@/views/Photos/PhotoTable.vue'  
  export default {
    name: 'PhotosIndex',
    components:{
      tablePhotos,
    },
    data() {
      return {
        title:"Photos",      
      recommendation: [],
        headers: [
          { text: 'Estado', value: 'Mood', sortable: false },     
          { text: ' Porcentage', value: 'Percentage' },
          { text: '', value: 'action', sortable: false }
        ],
        path: '/songs'
      }
    },
    created () {
      // var self = this
      // axios.get('https://6nlk8s2xu7.execute-api.us-west-1.amazonaws.com/dev/api/v1/users')
      // .then(function(r){
      //   self.recommendation = r.data
        
      // })
      // .catch(function(r){
      //   console.log(r)
      //   self.recommendation = []
      // })
    },
    edit(id) {
        this.$router.push({
                path: '/beer/edit/' + id
            });

        },

    methods: {
    }
  }
</script>