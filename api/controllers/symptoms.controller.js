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
    const id = req.query.id;
    var condition = id ? { id: { [Op.like]: `%${id}%` } } : null;
  
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
  const id = req.params.id;

  Symptom.findByPk(id)
    .then(data => {
      if (data) {
        res.send(data);
      } else {
        res.status(404).send({
          message: `Cannot find Symptom with id=${id}.`
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving Symptom with id=" + id
      });
    });
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
exports.findAllDificulty = (req, res) => {
  Symptoms.findAll({ where: { difficulty_breathing: 'Yes' } })
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving symptoms."
      });
    });
};