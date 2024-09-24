
const authorizeRoles = (...permittedRoles) => {
  return (req, res, next) => {
    const user = req.user;
    if (user && permittedRoles.includes(user.role)) {
      next();
    } else {
      res.status(403).json({ message: 'Forbidden' });
    }
  };
}

module.exports = authorizeRoles;