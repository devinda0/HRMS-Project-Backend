const db = require('../../../config/db');

const getAllEmployees = async () => {
    const query = `CALL GET_ALL_EMPLOYEES()`;
    console.log(query);
    const [rows] = await db.query(query);
    return rows[0];
}


module.exports = {
    getAllEmployees
};