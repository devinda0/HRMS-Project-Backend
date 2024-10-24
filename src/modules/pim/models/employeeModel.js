const db = require('../../../config/db');

const getAllEmployees = async () => {
    const query = `CALL GET_ALL_EMPLOYEES()`;
    console.log(query);
    const [rows] = await db.query(query);
    return rows[0];
}

const getEmployeeDependantInformationById = async(employee_id) =>{
    const query = `CALL GET_DEPENDANTS_BY_EMPLOYEE_ID(?)`;
    const [rows] = await db.query(query,[employee_id]);

    return rows[0];
}

const getEmployeeContactInformation = async(employee_id) =>{
    const query = `CALL GET_EMERGENCY_CONTACT_BY_EMPLOYEE_ID(?)`;
    const [rows] = await db.query(query,[employee_id]);

    return rows[0];
}

const updateDependantInformation = async(dependant_id, name, employee_id, birthday, relation, gender) =>{
    const query = `CALL UPDATE_DEPENDANT_INFO(?, ?, ?, ?, ?, ?)`;
    const [rows] = await db.query(query,[dependant_id, name, employee_id, birthday, relation, gender]);

    return rows[0][0];
}

module.exports = {
    getAllEmployees,
    getEmployeeDependantInformationById,
    getEmployeeContactInformation,
    updateDependantInformation
};