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
router.post('/dependants', userController.addDependant);
router.post('/emergency-contacts', userController.addEmergencyContact);
router.put('/', userController.updateUserDetails);
router.put('/dependants', userController.updateDependant);
router.put('/emergency-contacts', userController.updateEmergencyContact);
router.put('/custom-attributes', userController.updateCustomAttributes);
router.delete('/dependants/:id', userController.deleteDependant);
router.delete('/emergency-contacts/:contact_no', userController.deleteEmergencyContact);


module.exports = router;