module.exports = (sequelize, Sequelize) => {
  const Photo = sequelize.define("Photo", {
    id: {
      type: Sequelize.INTEGER
    },
    name: {
      type: Sequelize.STRING
    },
    username: {
      type: Sequelize.STRING
    },
    address: {
      type: Sequelize.STRING
    }
    ,
    phone: {
      type: Sequelize.STRING
    }
    ,
    company: {
      type: Sequelize.STRING
    }
    
  });

  return Photo;
};