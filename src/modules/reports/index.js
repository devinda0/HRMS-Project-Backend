const express = require('express');
const route = express.Router();
const reportController = require('./controllers/reportControler');

route.get('/employees', reportController.getEmployeesReport);
route.get('/leave_count', reportController.getLeaveCountReport);
route.get('/filter_by_values', reportController.getFilterByValues);

module.exports = route;