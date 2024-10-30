const db = require('../../../config/db');

const findByUsername = async (username) => {
    const query = `CALL GET_USER_BY_USERNAME(?)`
    const [rows] = await db.query(query, [username]);

    return rows[0];
}

const updateUserByEmployeeId = async (employee) => {
    const query = `CALL UPDATE_EMPLOYEE_BY_ID(?,?,?,?,?,?,?,?,?,?,?,?,?)`;
    const [rows] = await db.query(query, [
        employee.employee_id,
        employee.name,
        employee.email,
        employee.address,
        employee.gender,
        employee.birthday,
        employee.phone,
        employee.marital_status,
        employee.supervisor,
        employee.job_title_id,
        employee.pay_grade,
        employee.employment_status,
        employee.branch_id        
    ]);
    return rows[0];
}

const getEmergencyContactsByEmployeeId = async (id) => {
    const query = `CALL GET_EMERGENCY_CONTACT_BY_EMPLOYEE_ID(?)`;
    const [rows] = await db.query(query, [id]);
    return rows[0];
}

const getUserDetailsByEmployeeID = async (id) => {
    const query = `CALL GET_EMPLOYEE_BY_ID(?)`;
    const [rows] = await db.query(query, [id]);
    if (rows[0].length === 0) {
        throw new Error('Employee not found');
    }
    return rows[0][0];
} 

const getCustomAttributesByEmployeeId = async (employeeId) => {
    const query = `CALL GET_EMPLOYEE_ATTRIBUTE_BY_EMPLOYEE_ID(?)`;
    const [rows] = await db.query(query, [employeeId]);
    return rows[0];
}

const updateCustomAttributesByEmployeeId = async (employeeId, customAttributes) => {
    const query = `CALL UPDATE_EMPLOYEE_ATTRIBUTE(?,?)`;
    const [rows] = await db.query(query, [employeeId, customAttributes]);
    return rows[0];
}

const addNewDependant = async (dependant) => {
    const query = `CALL ADD_DEPENDANT(?,?,?,?,?)`;
    const [rows] = await db.query(query, [
        dependant.name,
        dependant.employee_id,
        dependant.birthday,
        dependant.relation,
        dependant.gender,
    ]);
    return rows[0];
}

const addNewEmergencyContact = async (emergencyContact) => {
    const query = `CALL ADD_EMERGENCY_CONTACT(?,?,?,?)`;
    const [rows] = await db.query(query, [
        emergencyContact.employee_id,
        emergencyContact.contact_name,
        emergencyContact.relationship,
        emergencyContact.contact_no,
    ]);
    return rows[0];
}

const updateDependant = async (dependant) => {
    const query = `CALL UPDATE_DEPENDANT(?,?,?,?,?)`;
    const [rows] = await db.query(query, [
        dependant.dependant_id,
        dependant.name,
        dependant.birthday,
        dependant.relation,
        dependant.gender,
    ]);
    return rows[0];
}

const deleteDependant = async (dependantId) => {
    const query = `CALL DELETE_DEPENDANT(?)`;
    const [rows] = await db.query(query, [dependantId]);
    return rows[0];
}

const updateEmergencyContact = async (emergencyContact) => {
    const query = `CALL UPDATE_EMERGENCY_CONTACT(?,?,?,?,?)`;
    const [rows] = await db.query(query, [
        emergencyContact.employee_id,
        emergencyContact.old_contact_no,
        emergencyContact.new_contact_no,
        emergencyContact.relationship,
        emergencyContact.contact_name,
    ]);
    console.log(rows);
    return rows[0];
}

const deleteEmergencyContact = async (employee_id, contact_no) => {
    const query = `CALL DELETE_EMERGENCY_CONTACT(?,?)`;
    const [rows] = await db.query(query, [employee_id, contact_no]);
    return rows[0];
}

const getCustomAttributes = async () => {
    const query = `CALL GET_CUSTOM_ATTRIBUTE()`;
    const [rows] = await db.query(query);
    return rows[0];
}

const getDependantsByEmployeeId = async (id) => {
    const query = `CALL GET_DEPENDANTS_BY_EMPLOYEE_ID(?)`;
    const [rows] = await db.query(query, [id]);
    return rows[0];
}

const getUserDetailsBriefById = async (id) => {
    const query = `CALL GET_EMPLOYEE_BRIEF_BY_ID(?)`;
    const [rows] = await db.query(query, [id]);
    return rows[0][0];
}

module.exports = {
    findByUsername,
    updateUserByEmployeeId,
    getUserDetailsByEmployeeID,
    getCustomAttributesByEmployeeId,
    updateCustomAttributesByEmployeeId,
    addNewDependant,
    addNewEmergencyContact,
    updateDependant,
    deleteDependant,
    updateEmergencyContact,
    deleteEmergencyContact,
    getCustomAttributes,
    getDependantsByEmployeeId,
    getEmergencyContactsByEmployeeId,
    getUserDetailsBriefById,
}