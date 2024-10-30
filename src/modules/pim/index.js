const express = require('express');
const employeeController = require('./controllers/employeeController');

const route = express.Router();

route.get('/employees', employeeController.getAllEmployees);
route.get('/employees/count', employeeController.getEmployeeCount);
route.get('/employees/:id', employeeController.getEmployeeById);
route.get('/employees/:id/dependants', employeeController.getDependantsByEmployeeId);
route.get('/employees/:id/emergency-contacts', employeeController.getEmergencyContactsByEmployeeId);
route.put('/employees', employeeController.updateEmployee);
route.get('/branches', employeeController.getAllBranches);
route.get('/job-titles', employeeController.getAllJobTitles);
route.get('/pay-grades', employeeController.getAllPayGrades);
route.put('/dependants', employeeController.updateDependant);
route.delete('/dependants/:id', employeeController.deleteDependant);
route.put('/emergency-contacts', employeeController.updateEmergencyContact);
route.delete('/emergency-contacts/:employee_id/:contact_no', employeeController.deleteEmergencyContact);
route.post('/employees', employeeController.addNewEmployee);
route.post('/dependants', employeeController.addNewDependant);
route.post('/emergency-contacts', employeeController.addNewEmergencyContact);
route.get('/custom-attributes', employeeController.getCustomAttributes);
route.post('/custom-attributes', employeeController.addCustomAttribute);
route.delete('/custom-attributes/:id', employeeController.deleteCustomAttribute);
route.get('/employees/:id/custom-attributes', employeeController.getEmployeeCustomAttributes);
route.put('/employees/:id/custom-attributes', employeeController.updateEmployeeCustomAttributes);
route.post('/users', employeeController.createUserAccount);

module.exports = route;