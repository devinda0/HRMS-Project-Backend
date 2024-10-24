const db = require('../../../config/db');

const getAllEmployees = async () => {
    const query = `CALL GET_ALL_EMPLOYEES()`;
    console.log(query);
    const [rows] = await db.query(query);
    return rows[0];
}

// Add Employee Dependent Information
const addDependent = async (dependentData) => {
    const { name, employee_id, birthday, relation, gender } = dependentData;
    const query = `CALL ADD_DEPENDANT(?, ?, ?, ?, ?)`;
    console.log(query, [name, employee_id, birthday, relation, gender]);
    const [result] = await db.query(query, [name, employee_id, birthday, relation, gender]);
    return result;
}

// Add Employee Contact Information
const addEmergencyContact = async (contactData) => {
    const { employee_id, relation, contact_no } = contactData;
    const query = CALL `ADD_EMERGENCY_CONTACT(?, ?, ?)`;
    console.log(query, [employee_id, relation, contact_no]);
    const [result] = await db.query(query, [employee_id, relation, contact_no]);
    return result;
}

// Update Employee Contact Information
const updateEmergencyContact = async (updateData) => {
    const { employee_id, new_relation, old_contact_no, new_contact_no } = updateData;
    const query = CALL `UPDATE_EMERGENCY_CONTACT(?, ?, ?, ?)`;
    console.log(query, [employee_id, new_relation, old_contact_no, new_contact_no]);
    const [result] = await db.query(query, [employee_id, new_relation, old_contact_no, new_contact_no]);
    return result;
}


module.exports = {
    getAllEmployees,
    addDependent,
    addEmergencyContact,
    updateEmergencyContact
};