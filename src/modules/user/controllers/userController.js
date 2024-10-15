const User = require('../models/userModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');


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

        res.status(200).json({ accessToken });
    });
};

const userLogout = (req, res) => {
    res.clearCookie('refreshToken');
    res.status(200).json({ message: 'Logged out' });
}

module.exports = {
    userLogin,
    userLogout,
    refreshToken
}