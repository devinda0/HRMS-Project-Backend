const Absence = require('../models/absenceModel');

const addLeave = async (req, res) => {
    const { start_date, end_date, leave_type, reason } = req.body;
    const employee_id = req.user.employee_id;

    if (!start_date || !end_date || !leave_type || !reason) {
        return res.status(400).json({ message: 'Please provide all the required fields' });
    }

    if (new Date(start_date) > new Date(end_date)) {
        return res.status(400).json({ message: 'Start date should be less than end date' });
    }

    try {
        const leave = await Absence.addLeave({ start_date, end_date, leave_type, employee_id, reason });
        res.status(201).json({ message: 'Leave added successfully', leave });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

const getLeavesByStatus = async (req, res) => {
    const employee_id = req.user.employee_id;
    let leave_status = req.params.leave_status;

    try {

        switch (leave_status.toLowerCase()) {
            case 'pending':
                leave_status = 'Pending';
                break;
            case 'approved':
                leave_status = 'Approved';
                break;
            case 'rejected':
                leave_status = 'Rejected';
                break;
            case 'cancelled':
                leave_status = 'Cancelled';
                break;
            default:
                return res.status(400).json({ message: 'Invalid leave status' });
        }

        const leaves = await Absence.getLeavesByStatus(employee_id, leave_status);

        res.status(200).json({ leaves });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

const getLeaveCount = async (req, res) => {
    const employee_id = req.user.employee_id;

    try {
        const leaveCount = await Absence.getLeaveCount(employee_id);
        const totalLeaveCount = await Absence.getTotalLeaveCount(employee_id);

        res.status(200).json({ leaveCount, totalLeaveCount:totalLeaveCount });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

const cancelPendingLeave = async (req, res) => {
    const leave_id = req.params.leave_id;
    const employee_id = req.user.employee_id;

    try {
        const leave = await Absence.getLeaveById(leave_id);

        if (!leave) {
            return res.status(404).json({ message: 'Leave not found' });
        }

        if (leave.employee_id !== employee_id) {
            return res.status(403).json({ message: 'Forbidden' });
        }

        if (leave.leave_status !== 'Pending') {
            return res.status(400).json({ message: 'Leave cannot be cancelled' });
        }

        await Absence.updateLeaveStatus(leave_id, 'Cancelled');

        res.status(200).json({ message: 'Leave cancelled successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

const getSubordinatesLeaves = async (req, res) => {
    const employee_id = req.user.employee_id;
    let leave_status = req.params.leave_status;


    switch (leave_status.toLowerCase()) {
        case 'pending':
            leave_status = 'Pending';
            break;
        case 'approved':
            leave_status = 'Approved';
            break;
        case 'rejected':
            leave_status = 'Rejected';
            break;
        case 'cancelled':
            leave_status = 'Cancelled';
            break;
        default:
            return res.status(400).json({ message: 'Invalid leave status' });
    }

    try {
        const leaves = await Absence.getSubordinatesLeaves(employee_id, leave_status);

        res.status(200).json({ leaves });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

const approveLeave = async (req, res) => {
    const leave_id = req.params.leave_id;
    const employee_id = req.user.employee_id;

    try {
        const leave = await Absence.getLeaveById(leave_id);

        if (!leave) {
            return res.status(404).json({ message: 'Leave not found' });
        }

        if (leave.supervisor_id !== employee_id) {
            return res.status(403).json({ message: 'Forbidden' });
        }

        if (leave.leave_status !== 'Pending') {
            return res.status(400).json({ message: 'Leave cannot be approved' });
        }

        await Absence.updateLeaveStatus(leave_id, 'Approved');

        res.status(200).json({ message: 'Leave approved successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

const declineLeave = async (req, res) => {
    const leave_id = req.params.leave_id;
    const employee_id = req.user.employee_id;

    try {
        const leave = await Absence.getLeaveById(leave_id);

        if (!leave) {
            return res.status(404).json({ message: 'Leave not found' });
        }

        if (leave.supervisor_id !== employee_id) {
            return res.status(403).json({ message: 'Forbidden' });
        }

        if (leave.leave_status !== 'Pending') {
            return res.status(400).json({ message: 'Leave cannot be declined' });
        }

        await Absence.updateLeaveStatus(leave_id, 'Declined');

        res.status(200).json({ message: 'Leave declined successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

const checkEmployeeIsSuperVisor = async (req, res) => {
    const employee_id = req.user.employee_id;

    try {
        const subordinates = await Absence.getSubordinatesCount(employee_id);

        const isSupervisor = subordinates.length > 0;

        res.status(200).json({ isSupervisor });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

module.exports = {
    addLeave,
    cancelPendingLeave,
    getSubordinatesLeaves,
    approveLeave,
    declineLeave,
    getLeaveCount,
    getLeavesByStatus,
    checkEmployeeIsSuperVisor
};