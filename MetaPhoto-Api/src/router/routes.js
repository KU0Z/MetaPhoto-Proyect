const express = require('express')
const router = express.Router()
const responses = require('../utils/responses')

const photoController = require('../controllers/photoController')


router.get('/healthcheck', (req, res) => {
  res.status(200).json(responses.webResponse(true, 'Health check ok'));
});

// Get survey by subdomain
router.get('/photos/:photosId', photoController.getPhotos);

module.exports = router;
