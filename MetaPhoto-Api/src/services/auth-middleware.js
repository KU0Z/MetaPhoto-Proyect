const jwt = require('jsonwebtoken');

function authMiddleware(req, res, next) {
    const token = req.headers['access-token'];

    if (token) {
        jwt.verify(token, process.env.TOKEN_SECRET, (err, decoded) => {
            if (err) {
                return res.json({
                    success: false,
                    message: "La sesión no es valida o ha expirado."
                });
            } else {
                req.decoded = decoded;
                next();
            }
        });
    } else {
        res.json({
            success: false,
            message: "La sesión no es valida o ha expirado."
        });
    }
}

module.exports = authMiddleware;
