const db = require('../../../config/db');

const addLeave = async (leave) => {
    const query = `CALL ADD_LEAVE(?, ?, ?, ?, ?)`;
    const [rows] = await db.query(query, [leave.start_date, leave.end_date, leave.leave_type, leave.employee_id, leave.reason]);

    return rows[0];
}

const getLeaves = async (employee_id, leave_type) => {
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

    return rows[0];
}

const getTotalLeaveCount = async (employee_id) => {
    const query = `CALL GET_TOTAL_LEAVE_COUNT(?)`;
    const [rows] = await db.query(query, [employee_id]);

    return rows[0];
}

module.exports = {
    addLeave,
    getLeaves,
    updateLeaveStatus,
    getLeaveCount,
    getTotalLeaveCount
}