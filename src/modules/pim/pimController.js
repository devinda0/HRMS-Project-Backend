const Employee = require('../models/pimModel');

const getEmployeeDependantInformationById = async (req, res) => {
    try {
        const employeeId = req.user.employee_id;
        
        const dependants = await Employee.getEmployeeDependantInformationById(employeeId);
        
        if (dependants.length === 0) {
            return res.status(404).json({ message: 'No dependants found for the given employee ID' });
        }
        
        res.status(200).json(dependants);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
};

const getEmployeeEmergencyContact = async (req, res) => {
    try {
        const employeeId = req.user.employee_id;

        const contactInfo = await Employee.getEmployeeContactInformation(employeeId);

        if (contactInfo.length === 0) {
            return res.status(404).json({ message: 'No emergency contact information found for the given employee ID' });
        }

        res.status(200).json(contactInfo);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
};

module.exports = {
    getEmployeeDependantInformationById,
    getEmployeeEmergencyContact
};


