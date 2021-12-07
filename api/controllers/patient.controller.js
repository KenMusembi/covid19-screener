const db = require("../models");
const Patient = db.patients;
const OP = db.Sequelize.Op;

//create and save a new patient
exports.create = (req, res)=>{  

// Create a Patient record
const patient = {
  p_name: req.body.p_name,
  p_email: req.body.p_email,
  p_username: req.body.p_username,
  p_phone_number: req.body.p_phone_number,
  p_password: req.body.p_password
};
  
// Save Patient in the database
Patient.create(patient)
  .then(data => {
    res.send(data);
  })
  .catch(err => {
    res.status(500).send({
      message:
        err.message || "Error while creating patient record, please retry."
    });
  });
};

//retrieve all patients
exports.findAll = (req, res)=> {
    const p_username = req.query.p_username;
    var condition = p_username ? { p_username: { [Op.like]: `%${p_username}%` } } : null;
  
    Patient.findAll({ where: condition })
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Error while retrieving patient records, kindly retry."
        });
      });
};


//T0-DO 
//find a single patient with id
exports.findOne = (req, res) => {

};

//update patient details by the id in the request
exports.update = (req, res) => {

};

//delete a patient with the specified id in the request
exports.delete = (req, res) => {

};

//delete a  patient from the database
exports.deleteAll = (req, res)=>{

};

//find all screened patients
exports.findAllScreened = (req, res)=> {

};