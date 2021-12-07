module.exports = app => {
    //reference symptoms controller
    const symptoms = require("../../controllers/symptoms.controller");
  
    var router = require("express").Router();
  
    // Create a new Symptom
    router.post("/createSymptom", symptoms.create);
  
    // Retrieve all Symptoms
    router.get("/listSymptoms", symptoms.findAll);

    //retrieve all symptoms with condition
    router.get("/", symptoms.findAll);

    //retrieve symptom by id
    router.get("/:id", symptoms.findOne);

    //retieve symptoms where there is difficulty breathing
    router.get("/difficulty", symptoms.findAllDificulty);
  
    app.use('/api/patients', router);
  };