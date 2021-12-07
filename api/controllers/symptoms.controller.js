const db = require("../models");
const Symptom = db.symptoms;
const OP = db.Sequelize.Op;

//create and save a new symptom relations
exports.create = (req, res)=>{

// Create a Symptom
const symptom = {
  p_id: req.body.p_id,
  fever: req.body.fever,
  cough: req.body.cough,
  difficulty_breathing: req.body.difficulty_breathing,
  chills: req.body.chills
};
  
// Save Symptom in the database
Symptom.create(symptom)
  .then(data => {
    res.send(data);
  })
  .catch(err => {
    res.status(500).send({
      message:
        err.message || "Error while adding data, kindly retry."
    });
  });
};

//retrieve all symptoms
exports.findAll = (req, res)=> {
    const p_id = req.query.p_id;
    var condition = p_id ? { p_id: { [Op.like]: `%${p_id}%` } } : null;
  
    Symptom.findAll({ where: condition })
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Error while retrieving symptoms, kindly retry."
        });
      });
};


//TO-DO
//find a single syptom with id
exports.findOne = (req, res) => {

};

//update symptom details by the id in the request
exports.update = (req, res) => {

};

//delete a symptom with the specified id in the request
exports.delete = (req, res) => {

};

//delete a  symptom from the database
exports.deleteAll = (req, res)=>{

};

//find all positive symptoms
exports.findAllPositive = (req, res)=> {

};