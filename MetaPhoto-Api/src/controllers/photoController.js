const responses = require('../utils/responses');
const request = require("request");
const axios = require('axios')
//const { param } = require('../router/routes');
const url = 'https://jsonplaceholder.typicode.com/'

exports.getPhotos = async (req, res, next) => {
 try {
  // Validate security
  let photos = await axios.get(url+'photos');
  let users = await axios.get(url+'users');
  //users=JSON.parse(JSON.stringify(users.data))
  let albums = await axios.get(url+'albums');
  console.log(users.data)  
  // albums = albums.data.map((albums,i) => {
  //                 albums.user =users.data.find(x => x.id === albums.userId)
  //                 return albums
  //                 })
  // photos = photos.data.map((photos,i) => {
  //                 photos.album =albums.find(x => x.id === photos.albumId)
  //                 return photos
  //                 })  
  albums = albums.data.map((albums,i) => {
                    //albums.user =users.data.find(x => x.id === albums.userId)
                    return {  id:albums.id,
                              title:albums.title,
                              user:users.data.find(x => x.id === albums.userId)
                    }
                    })
  photos = photos.data.map((photos,i) => {
                    //photos.album =albums.find(x => x.id === photos.albumId)
                    return {  
                      id:photos.id,
                      title:photos.title,
                      url:photos.url,
                      thumbnailUrl:photos.thumbnailUrl,
                      albums:albums.find(x => x.id === photos.albumId)
            }
                    })  
  console.log(albums)               
//        = {
//         photos:photos.data.ma,
//         albums:albums.data,
//         users:users.data
// }
   //console.log(result)    
         // let result = photos.map((photos) => {
  //   return {
  //           photos:photos,
  //           albums:albums,
  //           users:users
  //   }
  //   }) 
  res.status(200).json({ success: true, payload: photos});
  //res.status(200).json(responses.webResponse(true, 'Get Photos'));
  } catch (error) {
    console.error(error)
    res.status(500).json({ error: 'Something failed!' });
  }
}

