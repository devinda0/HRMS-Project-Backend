const db = require('../../../config/db');

const findByUsername = async (username) => {
    const query = `CALL GET_USER_BY_USERNAME(?)`
    const [rows] = await db.query(query, [username]);

    return rows[0];
}

module.exports = {
    findByUsername,
}