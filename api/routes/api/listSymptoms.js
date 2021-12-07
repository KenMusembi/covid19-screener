module.exports = app => {
    //reference symptoms controller
    const symptoms = require("../../controllers/symptoms.controller");
  
    var router = require("express").Router();
  
    // Create a new Symptom
    router.post("/createSymptom", symptoms.create);
  
    // Retrieve all Symptoms
    router.get("/listSymptoms", symptoms.findAll);
  
    app.use('/api/patients', router);
  };