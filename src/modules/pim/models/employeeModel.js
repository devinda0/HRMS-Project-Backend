const db = require('../../../config/db');

const getAllEmployees = async () => {
    const query = `CALL GET_ALL_EMPLOYEES()`;
    console.log(query);
    const [rows] = await db.query(query);
    return rows[0];
}
const saveEmployeeinfo=async(Personalinfo )=>{
    const query=`CALL UPDATE_EMPLOYEE_BY_ID(?,?,?,?,?,?,?,?,?,?)`
    console.log(query);
    const [rows]=await db.query(query,[Personalinfo.employee_id,Personalinfo.name,Personalinfo.email,Personalinfo.address,Personalinfo.birthday,Personalinfo.martial_status,Personalinfo.job_title,Personalinfo.pay_grade,Personalinfo.employment_status,Personalinfo.branch]);
    return rows[0];
}
const addEmployeeinfo=async(Personalinfo)=>{
    const query=`CALL ADD_EMPLOYEE(?,?,?,?,?,?,?,?,?,?)`;
    console.log(query);
    const[rows]=await db.query(query,[Personalinfo.name,Personalinfo.email,Personalinfo.address,Personalinfo.birthday,Personalinfo.martial_status,Personalinfo.job_title,Personalinfo.pay_grade,Personalinfo.employment_status,Personalinfo.branch,Personalinfo.supervisor]);
    return rows[0];
}
const getEmployeeinfo=async(employee_id)=>{
    const query = `CALL GET_ALL_EMPLOYEES(?)`;
    console.log(query,[employee_id]);
    const [rows] = await db.query(query,[employee_id]);
    return rows;
}


module.exports = {
    getAllEmployees,
    saveEmployeeinfo,
    addEmployeeinfo,
    getEmployeeinfo
};