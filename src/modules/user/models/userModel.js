const db = require('../../../config/db');

const findByUsername = async (username) => {
    const query = 'SELECT * FROM user WHERE username = ?';
    const [rows] = await db.query(query, [username]);

    return rows;
}

const getUserDetailsById = async (id) => {
    const query = `
        SELECT 
            employee_id, 
            name, 
            email, 
            address, 
            birthday, 
            supervisor_id, 
            marital_status,
            job_title,
            pay_grade,
            employment_status,
            branch_name
        FROM 
            employee JOIN branch ON employee.branch_id = branch.id 
            JOIN job_title ON employee.job_title_id = job_title.job_title_id
        WHERE employee_id = ?`;

    const [rows] = await db.query(query, [id]);

    return rows;
}

module.exports = {
    findByUsername,
    getUserDetailsById,
    
}