const express = require('express');
const employeeController = require('./controllers/employeeController');

const route = express.Router();

route.get('/employees', employeeController.getAllEmployees);
route.get('/employees/update/:employee_id', employeeController.updateEmployeeinfo);
route.get('/employees/add', employeeController.addEmployeeinfo);
route.get('/employees/getdetails/:employee_id', employeeController.getEmployeeinfo);

module.exports = route;