const db = require('../../../config/db');

const addLeave = async (leave) => {
    const query = `CALL ADD_LEAVE(?, ?, ?, ?, ?)`;
    const [rows] = await db.query(query, [leave.start_date, leave.end_date, leave.leave_type, leave.employee_id, leave.reason]);

    return rows[0];
}

const getLeavesByStatus = async (employee_id, leave_type) => {
    const query = `CALL GET_EMPLOYEE_LEAVES(?,?)`;
    const [rows] = await db.query(query, [employee_id, leave_type]);

    return rows[0];
}

const updateLeaveStatus = async (leave_id, status) => {
    const query = `CALL UPDATE_LEAVE_STATUS(?, ?)`;
    const [rows] = await db.query(query, [leave_id, status]);

    return rows[0];
}

const getLeaveCount = async (employee_id) => {
    const query = `CALL GET_LEAVE_COUNT(?)`;
    const [rows] = await db.query(query, [employee_id]);

    const leaveCount = {};

    rows[0].forEach((row) => {
        leaveCount[row.leave_type] = row.count;
    });

    return leaveCount;
}

const getTotalLeaveCount = async (employee_id) => {
    const query = `CALL GET_TOTAL_LEAVE_COUNT(?)`;
    const [rows] = await db.query(query, [employee_id]);

    return rows[0][0];
}

const getLeaveById = async (leave_id) => {
    const query = `CALL GET_LEAVE_BY_ID(?)`;
    const [rows] = await db.query(query, [leave_id]);

    return rows[0][0];
}

const deleteLeaveById = async (leave_id) => {
    const query = `CALL DELETE_LEAVE_BY_ID(?)`;
    const [rows] = await db.query(query, [leave_id]);

    return rows[0];
}

const getSubordinatesLeaves = async (supervisor_id, status) => {
    const query = `CALL GET_SUBORDINATES_LEAVES(?, ?)`;
    const [rows] = await db.query(query, [supervisor_id, status]);

    return rows[0];
}

module.exports = {
    addLeave,
    getLeavesByStatus,
    updateLeaveStatus,
    getSubordinatesLeaves,
    getLeaveById,
    deleteLeaveById,
    getLeaveCount,
    getTotalLeaveCount
}