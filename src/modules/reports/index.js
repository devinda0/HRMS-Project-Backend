const express = require('express');
const route = express.Router();
const reportController = require('./controllers/reportControler');
const authorizeRoles = require('../../middlewares/authorizeRoles');

route.get('/employees', authorizeRoles('Admin'), reportController.getEmployeesReport);
route.get('/leave_count', authorizeRoles('Admin'), reportController.getLeaveCountReport);
route.get('/filter_by_values', authorizeRoles('Admin'), reportController.getFilterByValues);

module.exports = route;