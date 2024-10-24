const express = require('express');
const employeeController = require('./controllers/employeeController');

const route = express.Router();

route.get('/employees', employeeController.getAllEmployees);
route.get('/employees/dependantinfo/:employee_id', employeeController.getEmployeeDependantInformationById);
route.get('/employees/contactinfo/:employee_id', employeeController.getEmployeeContactInformation);
route.put('/employees/updatedependants/:dependant_id', employeeController.updateDependantInformation);


module.exports = route;