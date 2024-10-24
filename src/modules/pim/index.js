const express = require('express');
const employeeController = require('./controllers/employeeController');

const route = express.Router();

route.get('/employees', employeeController.getAllEmployees);

module.exports = route;const express = require('express');
const employeeController = require('./pimController');

const route = express.Router();

route.get('/employees/dependants/:employee_id', employeeController.getEmployeeDependantInformationById);
route.get('/employees/emergencycontacts/:employee_id', employeeController.getEmployeeEmergencyContact);

module.exports = route;