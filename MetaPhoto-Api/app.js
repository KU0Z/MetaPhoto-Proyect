require('dotenv').config()
const createError = require('http-errors')
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const routes = require('./src/router/routes')
const app = express()
const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger.json');
var fs = require('fs');
const customCss = fs.readFileSync((process.cwd()+"/swagger.css"), 'utf8');
// let express to use this


try {
    app.use(cors())
    app.use(bodyParser.json())
    app.use(bodyParser.urlencoded({
        extended: true
    }))

    app.use('/api/externalapi', routes)
    app.use('/api/externalapi/', swaggerUi.serve, swaggerUi.setup(swaggerDocument, {customCss}));

    // catch 404 and forward to error handler
    app.use(function (req, res, next) {
        next(createError(404))
    })

    // error handler
    app.use(function (err, req, res, next) {
        // set locals, only providing error in development
        res.locals.message = err.message
        res.locals.error = req.app.get('env') === 'development' ? err : {}

        // render the error page
        res.status(err.status || 500)
        res.json({ message: res.locals.message })
    })

    let PORT

    if (process.env.NODE_ENV && (process.env.NODE_ENV === 'qa' || process.env.NODE_ENV === 'production')) {
        PORT = 80
        app.listen(PORT, () => console.info('Project listening on port 80'))
    } else {
        PORT = 3000
        app.listen(PORT, () => console.info('Project listening on port 3000'))
    }
} catch (e) {
    console.log(e)
}


