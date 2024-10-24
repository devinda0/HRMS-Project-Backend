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

const getEmployeeDependantInformationById = async (req, res) => {
    try {
        const employeeId = req.params.employee_id;
        
        const dependants = await Employee.getEmployeeDependantInformationById(employeeId);
        
        if (dependants.length === 0) {
            return res.status(404).json({ message: 'No dependants found for the given employee ID' });
        }
        
        res.status(200).json(dependants);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
}

const getEmployeeContactInformation = async (req, res) => {
    try {
        const employeeId = req.params.employee_id;

        const contactInfo = await Employee.getEmployeeContactInformation(employeeId);

        if (contactInfo.length === 0) {
            return res.status(404).json({ message: 'No emergency contact information found for the given employee ID' });
        }

        res.status(200).json(contactInfo);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
}

const updateDependantInformation = async(req, res) => {
    try {
        const {dependant_id, name, employee_id, birthday, relation, gender } = req.body;

        if(!dependant_id || !name || !employee_id || !birthday || !relation || !gender){
            return res.status(400).json({ message: 'All fields are required'});
        }

        const result = await Employee.updateDependantInformation(dependant_id, name, employee_id, birthday, relation, gender);

        if(result.affectedRows ===0){
            return res.status(404).json({ message: 'Dependant not found or no changes made'});
        }

        res.status(200).json({ message: 'Dependant information updated successfully.'});

    }catch(error){
        console.error(error);
        res.status(500).json({ message: 'Server error'});
    }
}

module.exports = {
    getAllEmployees,
    getEmployeeDependantInformationById,
    getEmployeeContactInformation,
    updateDependantInformation
};