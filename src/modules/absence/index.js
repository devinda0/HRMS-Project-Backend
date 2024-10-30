const express = require('express');
const absenceController = require('./controllers/absenceController');

const route = express.Router();

route.get('/leaves/:leave_status', absenceController.getLeavesByStatus);
route.get('/leave_count', absenceController.getLeaveCount);
route.post('/leave', absenceController.addLeave);
route.put('/leave/cancel/:leave_id', absenceController.cancelPendingLeave);
route.put('/leave/approve/:leave_id', absenceController.approveLeave);
route.put('/leave/decline/:leave_id', absenceController.declineLeave);
route.get('/leaves/subordinates/:leave_status', absenceController.getSubordinatesLeaves);
route.get('/is_supervisor', absenceController.checkEmployeeIsSuperVisor);


module.exports = route;