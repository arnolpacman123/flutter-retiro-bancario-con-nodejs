const { Router } = require('express');
const router = Router();
const {
    getAccount,
    checkAccount,
    checkBalance,
    registerAccount,
} = require('../controllers/account');

router.route('/:number').get(getAccount);
router.route('/checkaccount/:number').get(checkAccount);
router.route('/checkbalance/:number/:amount').get(checkBalance);
router.route('/register').post(registerAccount);

module.exports = router;