const express = require('express');
const employeeController = require('./controllers/employeeController');

const route = express.Router();

route.get('/employees', employeeController.getAllEmployees);
route.delete('/dependent/:dependant_id', employeeController.deleteDependent);


module.exports = route;