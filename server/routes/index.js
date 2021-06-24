const { Router } = require('express');
const router = Router();

const userRoutes = require('./user');
const accountRoutes = require('./account');
const withdrawalRoutes = require('./withdrawal');

router.use('/user', userRoutes);
router.use('/account', accountRoutes);
router.use('/withdrawal', withdrawalRoutes);

module.exports = router;