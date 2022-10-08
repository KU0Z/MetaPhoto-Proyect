module.exports = (sequelize, Sequelize) => {
  const Tutorial = sequelize.define("tutorial", {
    albumId: {
      type: Sequelize.INTEGER
    },
    id: {
      type: Sequelize.INTEGER
    },
    title: {
      type: Sequelize.STRING
    },
    url: {
      type: Sequelize.STRING
    },
    thumbnailUrl: {
      type: Sequelize.STRING
    }
    
  });

  return Tutorial;
};