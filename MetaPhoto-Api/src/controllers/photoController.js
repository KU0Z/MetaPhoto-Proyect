const responses = require('../utils/responses');
const request = require("request");
const axios = require('axios')
//const { param } = require('../router/routes');
const url = 'https://jsonplaceholder.typicode.com/'

exports.getPhotos = async (req, res, next) => {
 try {


  //Get params if exist
  let params = {
    title: req.query.title ? req.query.title : "",
    albumTitle: req.query.albumTitle ? req.query.albumTitle : "",
    albumUserEmail: req.query.albumUserEmail ? req.query.albumUserEmail : "",
    limit: parseInt(req.query.limit ? req.query.limit : "25"),
    offset: parseInt(req.query.offset ? req.query.offset : "0")
  };
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
                      album:albums.find(x => x.id === photos.albumId)
            }
                    })  
  console.log(photos)               
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

  //1.2: The filtering
  console.log(params)
  if (params.title !== "" ) {
    console.log("filtering title")
    photos=photos.filter(photos => photos.title.includes(params.title)) 
    console.log(photos)
    
  }
  if (params.albumTitle !== "") {
    console.log("filtering albumTitle")
    photos=photos.filter(photos => photos.album.title.includes(params.albumTitle)) 
  }
  if (params.albumUserEmail !== "") {
    console.log("filtering albumUserEmail")
    console.log(params.albumUserEmail)
    photos=photos.filter(photos => photos.album.user.email.includes(params.albumUserEmail)) 
  }
  console.log(req.query)
  //1.3: The pagination
  console.log("filtering albumUserEmail "+photos.length)
  let totalItems=photos.length

  let offset =params.offset
  if (offset<0) {
    offset = 0 
  } 
  if (offset>=photos.length) {
    offset = 0 
  } 
  
  let limit = offset+ params.limit
  if (limit<=offset) {
    limit = offset+25
  }
  if (limit>=photos.length) {
    limit = photos.length
  } 
  console.log("offset:",offset)
  console.log("limit:",limit)
  let totalPages=parseInt(photos.length/params.limit)
  photos = photos.slice(offset,limit);

  res.status(200).json({ success: true, offset:offset,limit:limit,totalItems:totalItems,totalPages:totalPages, payload: photos});
  //res.status(200).json(responses.webResponse(true, 'Get Photos'));
  //Sincere@april.biz
  //Sincere@april.biz.
  } catch (error) {
    console.error(error)
    res.status(500).json({ error: 'Something failed!' });
  }
}

