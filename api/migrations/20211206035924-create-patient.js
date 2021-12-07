'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('patients', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      p_name: {
        type: Sequelize.STRING
      },
      p_email: {
        type: Sequelize.STRING
      },
      p_username: {
        type: Sequelize.STRING
      },
      p_phone_number: {
        type: Sequelize.STRING
      },
      p_password: {
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
    await queryInterface.dropTable('patients');
  }
};