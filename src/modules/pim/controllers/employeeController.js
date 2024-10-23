const Employee = require('../models/employeeModel');

const getAllEmployees = async (req, res) => {
    console.log('getAllEmployees');
    try {
        const employees = await Employee.getAllEmployees();
        return res.status(200).json(employees);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}
const updateEmployeeinfo=async(req,res)=>{
    console.log("save personal information");
    const Personal_info=req.body;
    const {employee_id}=req.params;
    try{
        const updatedemployee=await Employee.saveEmployeeinfo({...Personal_info,employee_id:employee_id});
        return res.status(200).json({ message: "Employee updated successfully",updatedemployee });
    }catch(error){
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}
const addEmployeeinfo=async(req,res)=>{
    console.log("addEmployeeinfo");
    const Personalinfo=req.body;
    const supervisor=req.user.employee_id
    try{
        const newemployee=await Employee.addEmployeeinfo({ ...Personalinfo, supervisor: supervisor });
        return res.status(201).json({ message: "Employee added successfully",newemployee });
    }catch(error){
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}
const getEmployeeinfo=async(req,res)=>{
    console.log("getEmployeeinfo");
    const {employee_id}=req.params;
    try {
        const employeeinfo = await Employee.getEmployeeinfo(employee_id);
        return res.status(200).json(employeeinfo);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }

}

module.exports = {
    getAllEmployees,
    updateEmployeeinfo,
    addEmployeeinfo,
    getEmployeeinfo
};