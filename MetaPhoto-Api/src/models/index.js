
const Sequelize = require("sequelize");
const initModels = require("./init-models");

const sequelize = new Sequelize(process.env.DB_MAIN, process.env.DB_USER, process.env.DB_PASS, {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    dialect: "mysql",
    operatorsAliases: 0,
    logging: false, // process.env.NODE_ENV === 'production' ? false : console.log,
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    }
});

const db = {};
db.Sequelize = Sequelize;
db.sequelize = sequelize;
db.photos = require("./photos.model.js")(sequelize, Sequelize);
db.user = require("./users.model.js")(sequelize, Sequelize);
module.exports = db;