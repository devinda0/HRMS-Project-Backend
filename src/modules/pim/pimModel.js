const db = require('../../../config/db');

const getEmployeeDependantInformationById = async(employee_id) =>{
    const query = `CALL GET_DEPENDANTS_BY_EMPLOYEE_ID(?)`;
    const [rows] = await db.query(query,[employee_id]);

    return rows;
}

const getEmployeeContactInformation = async(employee_id) =>{
    const query = `CALL GET_EMERGENCY_CONTACT_BY_EMPLOYEE_ID(?)`;
    const [rows] = await db.query(query,[employee_id]);

    return rows;
}







module.exports = {
    getEmployeeDependantInformationById,
    getEmployeeContactInformation
};

