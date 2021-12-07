//initialize express js and path variables
const express = require('express');

//create object for express js
const app = express()

//parse requests of content-type - application/json
app.use(express.json());

//reference models and sync any changes
const db = require("./models");
db.sequelize.sync();

//import routes
require("./routes/api/listPatients")(app);
require("./routes/api/listSymptoms")(app);

const listPatients = require("./routes/api/listPatients");
const listSymptoms = require("./routes/api/listSymptoms");

//set port, listen for requests
const port = process.env.port|| 5000

app.listen(port, () =>console.log('server running succesfully'));