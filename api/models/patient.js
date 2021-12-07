 module.exports = (sequelize, Sequelize) => {
  const Patient = sequelize.define(
    "patient",
    {        
        p_name: {
            type: Sequelize.STRING(191),
            allowNull: false
        },        
        p_email: {
            type: Sequelize.STRING(191),
            allowNull: false,
            unique: "p_email_unique"
        },
        p_username: {
            type: Sequelize.STRING(191),
            allowNull: false,
            unique: "p_username_unique"
        },
        p_phone_number: {
            type: Sequelize.STRING(191),
            allowNull: false,
            unique: "p_phone_number_unique"
        },       
        p_password: {
            type: Sequelize.STRING(191),
            allowNull: false
            
        },
        p_dob: {
          type: Sequelize.DATE(191),
          allowNull: false
          
      },
        
    });
return Patient;
  };
  