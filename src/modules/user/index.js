const express = require('express');
const router = express.Router();
const userController = require('./controllers/userController');
const authorizeRoles = require('../../middlewares/authorizeRoles');

router.post('/login', userController.userLogin);
router.post('/logout', userController.userLogout);
router.post('/refresh_token', userController.refreshToken);


module.exports = router;