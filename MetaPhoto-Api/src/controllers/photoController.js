const responses = require('../utils/responses');
const request = require("request");
const axios = require('axios')
//const { param } = require('../router/routes');

exports.getPhotos = async (req, res, next) => {
 try {
  // Validate security
  res.status(200).json(responses.webResponse(true, 'Get Photos'));
  } catch (error) {
    console.error(error)
    res.status(500).json({ error: 'Something failed!' });
  }
}

