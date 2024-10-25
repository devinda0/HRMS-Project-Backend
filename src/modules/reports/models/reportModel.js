const db = require('../../../config/db');

const getEmployeesByDepartment = async (department) => {
    const query = 'CALL GET_EMPLOYEES_BY_DEPARTMENT(?)';
    const [rows] = await db.query(query, [department]);
    return rows[0];
}

const getEmployeesByBranch = async (branch) => {
    const query = 'CALL GET_EMPLOYEES_BY_BRANCH(?)';
    const [rows] = await db.query(query, [branch]);
    return rows[0];
}

const getEmployeesByJobTitle = async (jobTitle) => {
    const query = 'CALL GET_EMPLOYEES_BY_JOB_TITLE(?)';
    const [rows] = await db.query(query, [jobTitle]);
    return rows[0];
}

const getEmployeesByPayGrade = async (payGrade) => {
    const query = 'CALL GET_EMPLOYEES_BY_PAY_GRADE(?)';
    const [rows] = await db.query(query, [payGrade]);
    return rows[0];
}

const getEmployeesByEmploymentStatus = async (employmentStatus) => {
    const query = 'CALL GET_EMPLOYEES_BY_EMPLOYMENT_STATUS(?)';
    const [rows] = await db.query(query, [employmentStatus]);
    return rows[0];
}

const getLeaveCountByDepartment = async (from, to) => {
    const query = 'CALL GET_LEAVE_COUNT_BY_DEPARTMENT(?,?)';
    const [rows] = await db.query(query, [from, to]);
    return rows[0];
}

const getLeaveCountByBranch = async (from, to) => {
    const query = 'CALL GET_LEAVE_COUNT_BY_BRANCH(?,?)';
    const [rows] = await db.query(query, [from, to]);
    return rows[0];
}

const getLeaveCountByJobTitle = async (from, to) => {
    const query = 'CALL GET_LEAVE_COUNT_BY_JOB_TITLE(?,?)';
    const [rows] = await db.query(query, [from, to]);
    return rows[0];
}

const getLeaveCountByPayGrade = async (from, to) => {
    const query = 'CALL GET_LEAVE_COUNT_BY_PAY_GRADE(?,?)';
    const [rows] = await db.query(query, [from, to]);
    return rows[0];
}

const getLeaveCountByEmploymentStatus = async (from, to) => {
    const query = 'CALL GET_LEAVE_COUNT_BY_EMPLOYMENT_STATUS(?, ?)';
    const [rows] = await db.query(query, [from, to]);
    return rows[0];
}

 const getBranches = async () => {
    const query = 'CALL GET_ALL_BRANCHES()';
    const [rows] = await db.query(query);
    return rows[0];
 }

const getDepartments = async () => {
    const query = 'CALL GET_ALL_DEPARTMENTS()';
    const [rows] = await db.query(query);
    return rows[0];
}

const getJobTitles = async () => {
    const query = 'CALL GET_ALL_JOB_TITLES()';
    const [rows] = await db.query(query);
    return rows[0];
}

const getPayGrades = async () => {
    const query = 'CALL GET_ALL_PAY_GRADES()';
    const [rows] = await db.query(query);
    return rows[0];
}

const getEmploymentStatuses = async () => {
    const employmentStatuses = [
        'Intern_Fulltime',
        'Intern_Parttime',
        'Contract_Fulltime',
        'Contract_Parttime',
        'Permanent',
        'Freelance'
    ]
    return employmentStatuses;
}

module.exports = {
    getEmployeesByDepartment,
    getEmployeesByBranch,
    getEmployeesByJobTitle,
    getEmployeesByPayGrade,
    getEmployeesByEmploymentStatus,
    getLeaveCountByDepartment,
    getLeaveCountByBranch,
    getLeaveCountByJobTitle,
    getLeaveCountByPayGrade,
    getLeaveCountByEmploymentStatus,
    getDepartments,
    getBranches,
    getJobTitles,
    getPayGrades,
    getEmploymentStatuses
}
