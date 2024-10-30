const express = require('express');
const employeeController = require('./controllers/employeeController');
const authorizeRoles = require('../../middlewares/authorizeRoles');

const route = express.Router();

route.get('/employees', authorizeRoles('Admin','Manager'), employeeController.getAllEmployees);
route.get('/employees/count', authorizeRoles('Admin','Manager'), employeeController.getEmployeeCount);
route.get('/employees/:id', authorizeRoles('Admin','Manager'), employeeController.getEmployeeById);
route.get('/employees/:id/dependants', authorizeRoles('Admin','Manager'), employeeController.getDependantsByEmployeeId);
route.get('/employees/:id/emergency-contacts', authorizeRoles('Admin','Manager'), employeeController.getEmergencyContactsByEmployeeId);
route.put('/employees', authorizeRoles('Admin','Manager'), employeeController.updateEmployee);
route.get('/branches', employeeController.getAllBranches);
route.get('/job-titles', employeeController.getAllJobTitles);
route.get('/pay-grades', employeeController.getAllPayGrades);
route.put('/dependants', authorizeRoles('Admin','Manager'), employeeController.updateDependant);
route.delete('/dependants/:id', authorizeRoles('Admin','Manager'), employeeController.deleteDependant);
route.put('/emergency-contacts', authorizeRoles('Admin','Manager'), employeeController.updateEmergencyContact);
route.delete('/emergency-contacts/:employee_id/:contact_no', authorizeRoles('Admin','Manager'), employeeController.deleteEmergencyContact);
route.post('/employees', authorizeRoles('Admin','Manager'), employeeController.addNewEmployee);
route.post('/dependants', authorizeRoles('Admin','Manager'), employeeController.addNewDependant);
route.post('/emergency-contacts', authorizeRoles('Admin','Manager'), employeeController.addNewEmergencyContact);
route.get('/custom-attributes', employeeController.getCustomAttributes);
route.post('/custom-attributes', authorizeRoles('Admin','Manager'), employeeController.addCustomAttribute);
route.delete('/custom-attributes/:id', authorizeRoles('Admin','Manager'), employeeController.deleteCustomAttribute);
route.get('/employees/:id/custom-attributes', authorizeRoles('Admin','Manager'), employeeController.getEmployeeCustomAttributes);
route.put('/employees/:id/custom-attributes', authorizeRoles('Admin','Manager'), employeeController.updateEmployeeCustomAttributes);
route.post('/users', authorizeRoles('Admin','Manager'), employeeController.createUserAccount);

module.exports = route;