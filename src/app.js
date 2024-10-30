const express = require('express');
const app = express();
const bcrypt = require('bcrypt');
const pool = require('./config/db');
const jwt = require('jsonwebtoken');
const authenticateToken = require('./middlewares/authenticateToken');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const absenceModule = require('./modules/absence');
const userModule = require('./modules/user');
const pimModule = require('./modules/pim');
const reportModule = require('./modules/reports');

app.use(cors({
    origin: 'http://localhost:3000',
    credentials: true
}));
app.use(express.json());
app.use(cookieParser());

app.use('/user', userModule);
app.use(authenticateToken);

//call role based routes here... use authorizeRoles middleware to check the role of the user

app.use('/pim', pimModule);
app.use('/report', reportModule);
app.use('/absence', absenceModule);

module.exports = app;