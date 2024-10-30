const User = require('../models/userModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const mailer = require('../../../config/mailer');

const generatePassword = (length = 10) => {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()';
    const charactersLength = characters.length;

    let password = '';
    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * charactersLength);
        password += characters[randomIndex];
    }

    return password;
}

const userLogin = async (req, res) => {
    const { username, password } = req.body;

    try{
        const users = await User.findByUsername(username);

        if (users.length === 0) {
            return res.status(401).json({ message: 'Invalid username or password' });
        }

        const user = users[0];

        const isPasswordMatch = await bcrypt.compare(password, user.password);

        if (!isPasswordMatch) {
            return res.status(401).json({ message: 'Invalid username or password' });
        }

        const payload = { 
            employee_id: user.employee_id,
            role : user.role
        };
    

        const accessToken = jwt.sign( payload , process.env.ACCESS_TOKEN_SECRET, { expiresIn: '10min' });
        const refreshToken = jwt.sign(payload, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '1h' });

        res.cookie('refreshToken', refreshToken, { httpOnly: true,});
        res.status(200).json({ accessToken, role: user.role });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }

}

const refreshToken = (req, res) => {
    const refreshToken = req.cookies?.refreshToken;

    if (!refreshToken) {
        return res.status(401).json({ message: 'Unauthorized' });
    }

    jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (error, user) => {
        if (error) {
            return res.status(403).json({ message: 'Forbidden' });
        }

        const payload = { employee_id: user.employee_id, role: user.role };

        const accessToken = jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '10min' });
        const newRefreshToken = jwt.sign(payload, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '1h' });

        res.cookie('refreshToken', newRefreshToken, { httpOnly: true });
        res.status(200).json({ accessToken });
    });
};

const userLogout = (req, res) => {
    res.clearCookie('refreshToken');
    res.status(200).json({ message: 'Logged out' });
}

const getUserDetails = async (req, res) => {
    const employee_id = req.user.employee_id;

    try {
        const user = await User.getUserDetailsByEmployeeID(employee_id);
        return res.status(200).json(user);
    } 
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const updateUserDetails = async (req, res) => {
    const employee_id = req.user.employee_id;
    const inputData = req.body;

    if(!inputData.name || inputData.name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!inputData.email || inputData.email === '') {
        return res.status(400).json({ message: 'Email is required' });
    }

    if(!inputData.phone || inputData.phone === '') {
        return res.status(400).json({ message: 'Contact number is required' });
    }

    if(!inputData.address || inputData.address === '') {
        return res.status(400).json({ message: 'Address is required' });
    }

    if(!inputData.birthday || inputData.birthday === '') {
        return res.status(400).json({ message: 'Birthday is required' });
    }

    if(!inputData.marital_status || inputData.marital_status === '') {
        return res.status(400).json({ message: 'Marital status is required' });
    }

    if(!inputData.gender || inputData.gender === '') {
        return res.status(400).json({ message: 'Gender is required' });
    }

    try {
        const currentDetails = await User.getUserDetailsBriefById(employee_id);

        if((!!currentDetails.supervisor || !!inputData.supervisor) && currentDetails.supervisor !== inputData.supervisor) {
            return res.status(400).json({ message: 'Supervisor cannot be changed' });
        }

        if(currentDetails.job_title_id !== inputData.job_title_id) {
            return res.status(400).json({ message: 'Job Title cannot be changed' });
        }

        if(currentDetails.pay_grade !== inputData.pay_grade) {
            return res.status(400).json({ message: 'Pay Grade cannot be changed' });
        }

        if(currentDetails.employment_status !== inputData.employment_status) {
            return res.status(400).json({ message: 'Employment Status cannot be changed' });
        }

        if(currentDetails.branch_id !== inputData.branch_id) {
            return res.status(400).json({ message: 'Branch cannot be changed' });
        }

        const updatedDetails = {
            ...currentDetails,
            name : inputData.name,
            email : inputData.email,
            phone : inputData.phone,
            address : inputData.address,
            birthday : inputData.birthday,
            marital_status : inputData.marital_status,
            gender : inputData.gender,
        }

        const user = await User.updateUserByEmployeeId(inputData);
        return res.status(200).json(user);
    } 
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const getCustomAttributes = async (req, res) => {
    const employee_id = req.user.employee_id;

    try {
        const customAttributes = await User.getCustomAttributesByEmployeeId(employee_id);
        return res.status(200).json(customAttributes);
    } 
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const updateCustomAttributes = async (req, res) => {
    const employee_id = req.user.employee_id;
    const customAttributes = req.body;

    if(!customAttributes || customAttributes.length === 0) {
        return res.status(400).json({ message: 'Custom Attributes is required' });
    }

    try {
        const attributes = await User.getCustomAttributes();

        const newAttributes = attributes.map(attr => {
            if(customAttributes[attr.attribute_name]) {
                return {
                    attribute_id: attr.attribute_id,
                    attribute_name: attr.attribute_name,
                    value: customAttributes[attr.attribute_name]
                }
            } 
        });
        const addedAttributes = await User.updateCustomAttributesByEmployeeId(employee_id, JSON.stringify(newAttributes));
        return res.status(200).json(addedAttributes);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: error.message });
    }
}

const getDependants = async (req, res) => {
    const employee_id = req.user.employee_id;

    try {
        const dependants = await User.getDependantsByEmployeeId(employee_id);
        return res.status(200).json(dependants);
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const addDependant = async (req, res) => {
    const employee_id = req.user.employee_id;
    const inputData = req.body;

    if(!inputData.name || inputData.name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!inputData.birthday || inputData.birthday === '') {
        return res.status(400).json({ message: 'Birthday is required' });
    }

    if(!inputData.relation || inputData.relation === '') {
        return res.status(400).json({ message: 'Relation is required' });
    }

    if(!inputData.gender || inputData.gender === '') {
        return res.status(400).json({ message: 'gender is required' });
    }

    try {
        const dependant = await User.addNewDependant({
            name : inputData.name,
            employee_id : employee_id,
            birthday : inputData.birthday,
            relation : inputData.relation,
            gender : inputData.gender
        });
        return res.status(200).json(dependant);
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const updateDependant = async (req, res) => {
    const employee_id = req.user.employee_id;
    const inputData = req.body;

    if(!inputData.dependant_id || inputData.dependant_id === '') {
        return res.status(400).json({ message: 'Dependant ID is required' });
    }

    if(!inputData.name || inputData.name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!inputData.birthday || inputData.birthday === '') {
        return res.status(400).json({ message: 'Birthday is required' });
    }

    if(!inputData.relation || inputData.relation === '') {
        return res.status(400).json({ message: 'Relation is required' });
    }

    if(!inputData.gender || inputData.gender === '') {
        return res.status(400).json({ message: 'Gender is required' });
    }

    try {
        const oldDependants = await User.getDependantsByEmployeeId(employee_id);

        const oldDependant = oldDependants.find(dep => dep.dependant_id === inputData.dependant_id);

        if(!oldDependant) {
            return res.status(400).json({ message: 'Dependant not found' });
        }

        const dependant = await User.updateDependant({
            dependant_id : inputData.dependant_id,
            name : inputData.name,
            birthday : inputData.birthday,
            relation : inputData.relation,
            gender : inputData.gender
        });
        return res.status(200).json(dependant);
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const deleteDependant = async (req, res) => {
    const employee_id = req.user.employee_id;
    const dependant_id = req.params.id;

    try {
        const oldDependants = await User.getDependantsByEmployeeId(employee_id);
        console.log(oldDependants, dependant_id);
        const oldDependant = oldDependants.find(dep => dep.dependant_id === dependant_id);

        if(!oldDependant) {
            return res.status(400).json({ message: 'Dependant not found' });
        }

        const dependant = await User.deleteDependant(dependant_id);
        return res.status(200).json(dependant);
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const getEmergencyContacts = async (req, res) => {
    const employee_id = req.user.employee_id;

    try {
        const emergencyContacts = await User.getEmergencyContactsByEmployeeId(employee_id);
        return res.status(200).json(emergencyContacts);
    } 
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const addEmergencyContact = async (req, res) => {
    const employee_id = req.user.employee_id;
    const inputData = req.body;

    if(!inputData.contact_no || inputData.contact_no === '') {
        return res.status(400).json({ message: 'Contact Number is required' });
    }

    if(!inputData.contact_name || inputData.contact_name === '') {
        return res.status(400).json({ message: 'Name is required' });
    }

    if(!inputData.relationship || inputData.relationship === '') {
        return res.status(400).json({ message: 'Relationship is required' });
    }

    try {
        const emergencyContact = await User.addNewEmergencyContact({
            employee_id : employee_id,
            contact_no : inputData.contact_no,
            contact_name : inputData.contact_name,
            relationship : inputData.relationship
        });
        return res.status(200).json(emergencyContact);
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const updateEmergencyContact = async (req, res) => {
    const employee_id = req.user.employee_id;
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

    try {
        const oldContacts = await User.getEmergencyContactsByEmployeeId(employee_id);

        const oldContact = oldContacts.find(contact => contact.contact_no === oldData.contact_no);

        if(!oldContact) {
            return res.status(400).json({ message: 'Contact not found' });
        }

        const emergencyContact = await User.updateEmergencyContact({
            employee_id : employee_id,
            old_contact_no : oldContact.contact_no,
            new_contact_no : newData.contact_no,
            relationship : newData.relationship,
            contact_name : newData.contact_name
        });
        return res.status(200).json(emergencyContact);
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const deleteEmergencyContact = async (req, res) => {
    const employee_id = req.user.employee_id;
    const contact_no = req.params.contact_no;

    try {
        const oldContacts = await User.getEmergencyContactsByEmployeeId(employee_id);

        const oldContact = oldContacts.find(con => con.contact_no === contact_no);

        if(!oldContact) {
            return res.status(400).json({ message: 'Contact not found' });
        }

        const emergencyContact = await User.deleteEmergencyContact(employee_id, contact_no);
        return res.status(200).json(emergencyContact);
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Internal server error' });
    }
}

const forgetPassword = async (req, res) => {
    const { username, email } = req.body;

    try {
        const users = await User.findByUsername(username);

        if (users.length === 0) {
            return res.status(401).json({ message: 'Invalid username' });
        }

        const user = users[0];

        const userDetails = await User.getUserDetailsBriefById(user.employee_id);

        if(userDetails.email !== email) {
            return res.status(401).json({ message: 'Invalid email' });
        }

        const newPassword = generatePassword();

        const hashedPassword = await bcrypt.hash(newPassword, 10);

        const updatedUser = await User.updateUser({
            username: user.username,
            password: hashedPassword,
            role: user.role,
            employee_id: user.employee_id
        })

        console.log(user);

        mailer.sendMail({
            from: process.env.MAIL_USER,
            to: email,
            subject: 'Forget Password',
            text: `Your new password is ${newPassword}`
        });


        res.status(200).json({ updatedUser });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
    }
}

module.exports = {
    userLogin,
    userLogout,
    refreshToken,
    getUserDetails,
    updateUserDetails,
    getCustomAttributes,
    updateCustomAttributes,
    addDependant,
    updateDependant,
    deleteDependant,
    getEmergencyContacts,
    updateEmergencyContact,
    deleteEmergencyContact,
    addEmergencyContact,
    getDependants,
    forgetPassword
}