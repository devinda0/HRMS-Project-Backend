const Employee = require('../models/employeeModel');
const Dependent = require('../models/dependentModel');
const Contact = require('../models/contactModel');

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

const deleteDependent = async (req, res) => {
    const { dependant_id } = req.params;
    
    try {
        const result = await Dependent.deleteDependent(dependant_id);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Dependent not found' });
        }

        res.status(200).json({ message: 'Dependent deleted successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

const deleteContact = async (req, res) => {
    const { contact_id } = req.params;
    
    try {
        const result = await Contact.deleteContact(contact_id);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Contact information not found' });
        }

        res.status(200).json({ message: 'Contact information deleted successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}


module.exports = {
    getAllEmployees,
    deleteDependent,
    deleteContact,
};