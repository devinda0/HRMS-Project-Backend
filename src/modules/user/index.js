const express = require('express');
const router = express.Router();
const userController = require('./controllers/userController');
const authorizeRoles = require('../../middlewares/authorizeRoles');
const authorizeToken = require('../../middlewares/authenticateToken')

router.post('/login', userController.userLogin);
router.post('/logout', userController.userLogout);
router.post('/refresh_token', userController.refreshToken);
router.post('/forgot-password', userController.forgetPassword);

router.use(authorizeToken);

router.get('/', userController.getUserDetails);
router.get('/custom-attributes', userController.getCustomAttributes);
router.get('/dependants', userController.getDependants);
router.get('/emergency-contacts', userController.getEmergencyContacts);
router.post('/dependants', authorizeRoles('Admin','Manager','Employee_lvl2'), userController.addDependant);
router.post('/emergency-contacts', authorizeRoles('Admin','Manager','Employee_lvl2'), userController.addEmergencyContact);
router.put('/', authorizeRoles('Admin','Manager','Employee_lvl2'), userController.updateUserDetails);
router.put('/dependants', authorizeRoles('Admin','Manager','Employee_lvl2'), userController.updateDependant);
router.put('/emergency-contacts', authorizeRoles('Admin','Manager','Employee_lvl2'), userController.updateEmergencyContact);
router.put('/custom-attributes', authorizeRoles('Admin','Manager','Employee_lvl2'), userController.updateCustomAttributes);
router.delete('/dependants/:id', authorizeRoles('Admin','Manager','Employee_lvl2'), userController.deleteDependant);
router.delete('/emergency-contacts/:contact_no', authorizeRoles('Admin','Manager','Employee_lvl2'), userController.deleteEmergencyContact);


module.exports = router;