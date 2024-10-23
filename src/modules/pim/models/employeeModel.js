const db = require('../../../config/db');

const getAllEmployees = async () => {
    const query = `CALL GET_ALL_EMPLOYEES()`;
    console.log(query);
    const [rows] = await db.query(query);
    return rows[0];
}

const deleteDependent = async (dependant_id) => {
    const query = `CALL DELETE_DEPENDENT(?)`;
    const [rows] = await db.query(query, [dependant_id]);
    return rows[0];
}


const deleteContact = async (contact_id) => {
    const query = `CALL DELETE_CONTACT(?)`;
    const [rows] = await db.query(query, [contact_id]);
    return rows[0];
}

module.exports = {
    getAllEmployees,
    deleteDependent,
    deleteContact,
};