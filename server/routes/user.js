const { Router } = require('express');
const router = Router();
const {
    getUser,
    checkUser,
    registerUser,
    getUserById,
} = require('../controllers/user');

router.route('/:email').get(getUser);
router.route('/getuserbyid/:id').get(getUserById);
router.route('/checkuser/:email').get(checkUser);
router.route('/register').post(registerUser);

module.exports = router;