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

module.exports = {
    getAllEmployees
};