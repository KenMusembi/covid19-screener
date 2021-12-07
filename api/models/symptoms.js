module.exports = (sequelize, Sequelize) => {
  const Symptom = sequelize.define(
    "symptom",
    {        
        p_id: {
            type: Sequelize.STRING(191),
            allowNull: false
        },        
        fever: {
            type: Sequelize.STRING(191),
            allowNull: false,
            unique: "p_email_unique"
        },
        cough: {
            type: Sequelize.STRING(191),
            allowNull: false,
            unique: "p_username_unique"
        },
        difficulty_breathing: {
            type: Sequelize.STRING(191),
            allowNull: false,
            unique: "p_phone_number_unique"
        },       
        chills: {
            type: Sequelize.STRING(191),
            allowNull: false
            
        },
        
    });
return Symptom;
  };