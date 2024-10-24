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

// Add Employee Dependent Information
const addDependent = async (req, res) => {
    console.log('addDependent');
    try {
        const dependentData = req.body;
        const result = await Employee.addDependent(dependentData);
        return res.status(201).json({ message: 'Dependent added successfully.', data: result });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

// Add Employee Contact Information
const addEmergencyContact = async (req, res) => {
    console.log('addEmergencyContact');
    try {
        const contactData = req.body;
        const result = await Employee.addEmergencyContact(contactData);
        return res.status(201).json({ message: 'Emergency contact added successfully.', data: result });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

// Update Employee Contact Information
const updateEmergencyContact = async (req, res) => {
    console.log('updateEmergencyContact');
    try {
        const updateData = req.body;
        const result = await Employee.updateEmergencyContact(updateData);
        return res.status(200).json({ message: 'Emergency contact updated successfully.', data: result });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

module.exports = {
    getAllEmployees,
    addDependent,
    addEmergencyContact,
    updateEmergencyContact
};