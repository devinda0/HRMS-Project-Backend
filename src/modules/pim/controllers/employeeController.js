const Employee = require('../models/employeeModel');

const getAllEmployees = async (req, res) => {
    const position = req.query?.position || 0;
    const recordCount = req.query?.recordCount || 10;

    try {
        const employees = await Employee.getAllEmployees( position, recordCount );
        return res.status(200).json(employees);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const getEmployeeCount = async (req, res) => {
    try {
        const count = await Employee.getEmployeeCount();
        return res.status(200).json(count);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const getEmployeeById = async (req, res) => {
    try {
        const id = req.params.id;
        const employee = await Employee.getEmployeeById(id);
        return res.status(200).json(employee);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const getDependantsByEmployeeId = async (req, res) => {
    try {
        const id = req.params.id;
        const dependants = await Employee.getDependantsByEmployeeId(id);
        return res.status(200).json(dependants);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const getEmergencyContactsByEmployeeId = async (req, res) => {
    try {
        const id = req.params.id;
        const emergencyContacts = await Employee.getEmergencyContactsByEmployeeId(id);
        return res.status(200).json(emergencyContacts);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const updateEmployee = async (req, res) => {
    const employee = req.body;

    if(!employee.employee_id || employee.employee_id === '') {
        return res.status(400).json({ message: 'Employee ID is required' });
    }

    if(!employee.name || employee.name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!employee.email || employee.email === '') {
        return res.status(400).json({ message: 'Email is required' });
    }

    if(!employee.address || employee.address === '') {
        return res.status(400).json({ message: 'Address is required' });
    }

    if(!employee.birthday || employee.birthday === '') {
        return res.status(400).json({ message: 'Birthday is required' });
    }

    if(!employee.marital_status || employee.marital_status === '') {
        return res.status(400).json({ message: 'Marital Status is required' });
    }

    if(!employee.job_title_id || employee.job_title_id === '') {
        return res.status(400).json({ message: 'Job Title is required' });
    }

    if(!employee.pay_grade || employee.pay_grade === '') {
        return res.status(400).json({ message: 'Pay Grade is required' });
    }

    if(!employee.employment_status || employee.employment_status === '') {
        return res.status(400).json({ message: 'Employment Status is required' });
    }

    if(!employee.branch_id || employee.branch_id === '') {
        return res.status(400).json({ message: 'Branch is required' });
    }

    try {
        const updatedEmployee = await Employee.updateEmployee(employee);
        return res.status(200).json(updatedEmployee);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const getAllBranches = async (req, res) => {
    try {
        const branches = await Employee.getAllBranches();
        return res.status(200).json(branches);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const getAllJobTitles = async (req, res) => {
    try {
        const jobTitles = await Employee.getAllJobTitles();
        return res.status(200).json(jobTitles);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const getAllPayGrades = async (req, res) => {
    try {
        const payGrades = await Employee.getAllPayGrades();
        return res.status(200).json(payGrades);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const updateDependant = async (req, res) => {
    const dependant = req.body;

    if(!dependant.dependant_id || dependant.dependant_id === '') {
        return res.status(400).json({ message: 'Dependant ID is required' });
    }

    if(!dependant.name || dependant.name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!dependant.relation || dependant.relation === '') {
        return res.status(400).json({ message: 'Relationship is required' });
    }

    if(!dependant.birthday || dependant.birthday === '') {
        return res.status(400).json({ message: 'Birthday is required' });
    }

    if(!dependant.gender || dependant.gender === '') {
        return res.status(400).json({ message: 'Gender is required' });
    }

    try {
        const updatedDependant = await Employee.updateDependant(dependant);
        return res.status(200).json(updatedDependant);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const deleteDependant = async (req, res) => {
    const dependantId = req.params.id;

    if(!dependantId || dependantId === '') {
        return res.status(400).json({ message: 'Dependant ID is required' });
    }

    try {
        const deletedDependant = await Employee.deleteDependant(dependantId);
        return res.status(200).json(deletedDependant);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const updateEmergencyContact = async (req, res) => {
    const {oldData, newData} = req.body;

    if(!oldData || !newData) {
        return res.status(400).json({ message: 'Old and New Data is required' });
    }

    if(!oldData.contact_no) {
        return res.status(400).json({ message: 'Old Contact Number is required' });
    }

    if(!newData.contact_no) {
        return res.status(400).json({ message: 'New Contact Number is required' });
    }

    if(!newData.contact_name) {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!newData.relationship) {
        return res.status(400).json({ message: 'Relationship is required' });
    }

    if(!oldData.employee_id) {
        return res.status(400).json({ message: 'Employee ID is required' });
    }

    if(oldData.employee_id !== newData?.employee_id) {
        return res.status(400).json({ message: 'Employee ID mismatch' });
    }
    

    try {
        const emergencyContact = {
            employee_id: oldData.employee_id,
            old_contact_no: oldData.contact_no,
            new_contact_no: newData.contact_no,
            relationship: newData.relationship,
            contact_name: newData.contact_name
        };
        const updatedEmergencyContact = await Employee.updateEmergencyContact(emergencyContact);
        return res.status(200).json({ message: 'Emergency Contact Updated' });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const deleteEmergencyContact = async (req, res) => {
    const employee_id = req.params.employee_id;
    const contact_no = req.params.contact_no;

    if(!employee_id || employee_id === '') {
        return res.status(400).json({ message: 'Employee ID is required' });
    }

    if(!contact_no || contact_no === '') {
        return res.status(400).json({ message: 'Contact Number is required' });
    }

    try {
        const deletedEmergencyContact = await Employee.deleteEmergencyContact(employee_id, contact_no);
        return res.status(200).json({ message: 'Emergency Contact Deleted' });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const addNewEmployee = async (req, res) => {
    const employee = req.body;

    if(!employee.name || employee.name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!employee.email || employee.email === '') {
        return res.status(400).json({ message: 'Email is required' });
    }

    if(!employee.address || employee.address === '') {
        return res.status(400).json({ message: 'Address is required' });
    }

    if(!employee.birthday || employee.birthday === '') {
        return res.status(400).json({ message: 'Birthday is required' });
    }

    if(!employee.marital_status || employee.marital_status === '') {
        return res.status(400).json({ message: 'Marital Status is required' });
    }

    if(!employee.job_title_id || employee.job_title_id === '') {
        return res.status(400).json({ message: 'Job Title is required' });
    }

    if(!employee.pay_grade || employee.pay_grade === '') {
        return res.status(400).json({ message: 'Pay Grade is required' });
    }

    if(!employee.employment_status || employee.employment_status === '') {
        return res.status(400).json({ message: 'Employment Status is required' });
    }

    if(!employee.branch_id || employee.branch_id === '') {
        return res.status(400).json({ message: 'Branch is required' });
    }

    if(!employee.supervisor || employee.supervisor === '') {
        employee.supervisor = null;
    }

    try {
        const newEmployee = await Employee.addNewEmployee(employee);
        return res.status(200).json(newEmployee);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const addNewDependant = async (req, res) => {
    const dependant = req.body;

    if(!dependant.name || dependant.name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!dependant.employee_id || dependant.employee_id === '') {
        return res.status(400).json({ message: 'Employee ID is required' });
    }

    if(!dependant.birthday || dependant.birthday === '') {
        return res.status(400).json({ message: 'Birthday is required' });
    }

    if(!dependant.relation || dependant.relation === '') {
        return res.status(400).json({ message: 'Relationship is required' });
    }
    
    if(!dependant.gender || dependant.gender === '') {
        return res.status(400).json({ message: 'Gender is required' });
    }

    try {
        const newDependant = await Employee.addNewDependant(dependant);
        return res.status(200).json({ message: 'Dependant Added' });
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const addNewEmergencyContact = async (req, res) => {
    const emergencyContact = req.body;

    if(!emergencyContact.employee_id || emergencyContact.employee_id === '') {
        return res.status(400).json({ message: 'Employee ID is required' });
    }

    if(!emergencyContact.contact_name || emergencyContact.contact_name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!emergencyContact.relationship || emergencyContact.relationship === '') {
        return res.status(400).json({ message: 'Relationship is required' });
    }

    if(!emergencyContact.contact_no || emergencyContact.contact_no === '') {
        return res.status(400).json({ message: 'Contact Number is required' });
    }

    try {
        const newEmergencyContact = await Employee.addNewEmergencyContact(emergencyContact);
        return res.status(200).json({ message: 'Emergency Contact Added' });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

module.exports = {
    getAllEmployees,
    getEmployeeCount,
    getEmployeeById,
    getDependantsByEmployeeId,
    getEmergencyContactsByEmployeeId,
    updateEmployee,
    getAllBranches,
    getAllJobTitles,
    getAllPayGrades,
    updateDependant,
    deleteDependant,
    updateEmergencyContact,
    deleteEmergencyContact,
    addNewEmployee,
    addNewDependant,
    addNewEmergencyContact
};