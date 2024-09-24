const express = require('express');
const app = express();
const bcrypt = require('bcrypt');
const pool = require('./config/db');
const jwt = require('jsonwebtoken');
const authenticateToken = require('./middlewares/authenticateToken');

app.use(express.json());

app.post('/login', (req, res) => {
    const { username, password } = req.body;

    const query = 'SELECT * FROM user WHERE username = ?';

    pool.query(query, [username])
        .then( async ([rows]) => {
            if (rows.length === 0) {
                return res.status(401).json({ message: 'Invalid username or password' });
            }

            const user = rows[0];

            const isPasswordMatch = await bcrypt.compare(password, user.password);

            if (!isPasswordMatch) {
                return res.status(401).json({ message: 'Invalid username or password' });
            }

            const payload = { 
                username: user.username,
                role : user.role
            };

            const accessToken = jwt.sign( payload , process.env.ACCESS_TOKEN_SECRET, { expiresIn: '10min' });
            const refreshToken = jwt.sign(payload, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '1h' });

            res.cookie('refreshToken', refreshToken, { httpOnly: true });
            res.status(200).json({ accessToken });

        }).catch((error) => {
            console.error(error);
            res.status(500).json({ message: 'Internal server error' });
        });

});

//only for testing.. this is not part of the project
app.post('/signup', (req, res) => {
    const { username, password, role, employee_id } = req.body;

    const query = 'INSERT INTO user (username, password, role, employee_id) VALUES (?, ?, ?, ?)';

    bcrypt.hash(password, 10)
        .then((hashedPassword) => {
            return pool.query(query, [username, hashedPassword, role, employee_id]);
        }).then(([result]) => {
            res.status(201).json({ message: 'User created' });
        }).catch((error) => {
            console.error(error);
            res.status(500).json({ message: 'Internal server error' });
        });
});


app.use(authenticateToken);

//call role based routes here... use authorizeRoles middleware to check the role of the user

module.exports = app;