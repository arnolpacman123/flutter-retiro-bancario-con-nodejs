const { Router } = require('express');
const router = Router();
const {
    getWithdrawal,
    checkWithdrawal,
    registerWithdrawal
} = require('../controllers/withdrawal');

router.route('/:number').get(getWithdrawal);
router.route('/checkwithdrawal/:number').get(checkWithdrawal);
router.route('/register').post(registerWithdrawal);

module.exports = router;