module.exports = app => {
  //reference controller for patients crud
  const patients = require("../../controllers/patient.controller");

  var router = require("express").Router();

  // Create a new Patient
  router.post("/createPatient", patients.create);

  // Retrieve all Patients
  router.get("/listPatients", patients.findAll);

  app.use('/api/patients', router);
  };
