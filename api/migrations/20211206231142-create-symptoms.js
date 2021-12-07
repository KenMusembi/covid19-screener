'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('symptoms', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      p_id: {
        type: Sequelize.STRING
      },
      fever: {
        type: Sequelize.STRING
      },
      cough: {
        type: Sequelize.STRING
      },
      difficulty_breathing: {
        type: Sequelize.STRING
      },
      chills: {
        type: Sequelize.STRING
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('symptoms');
  }
};