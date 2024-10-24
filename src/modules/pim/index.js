const express = require('express');
const employeeController = require('./controllers/employeeController');

const route = express.Router();

route.get('/employees', employeeController.getAllEmployees);

route.post('/employees/dependents', employeeController.addDependent);
route.post('/employees/contacts', employeeController.addEmergencyContact);
route.put('/employees/contacts', employeeController.updateEmergencyContact);

module.exports = route;