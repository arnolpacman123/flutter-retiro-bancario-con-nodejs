const { request, response } = require('express');
const Account = require('../models/account');
const User = require('../models/user');

const getAccount = (req = request, res = response) => {
    Account.findOne({ number: req.params.number }, { __v: 0 })
        .populate('user', { accounts: 0, __v: 0 })
        .then((result) => {
            res.json({ data: result });
        })
        .catch((error) => {
            res.status(500).json({ msg: error });
        });
};

const checkAccount = (req = request, res = response) => {
    Account.findOne(
        { number: req.params.number },
        (error, result) => {
            if (error) return res.status(500).json({ msg: error });
            if (result !== null) {
                return res.json({
                    status: true,
                });
            } else {
                return res.json({
                    status: false,
                });
            }
        }
    );
};

const checkBalance = (req = request, res = response) => {
    Account.findOne(
        { number: req.params.number },
        (error, result) => {
            if (error) return res.status(500).json({ msg: error });
            if (req.params.amount <= result.balance ) {
                res.json({
                    status: true,
                });
            } else {
                res.json({
                    status: false
                });
            }
        }
    );
}

const registerAccount = (req = request, res = response) => {
    console.log('Inside the register');
    const account = new Account({
        number: req.body.number,
        type: req.body.type,
        balance: req.body.balance,
        user: req.body.user,
    });
    account.save((error) => {
        if (error) return res.status(403).json({ msg: error });
        console.log('Account registered');
        const _id = req.body.user;
        User.findByIdAndUpdate(
            { _id: _id },
            { $push: { accounts: account._id } },
            (error) => {
                if (error) return res.status(500).json({ msg: error });
            }
        );
        res.status(200).json('Ok');
    });
}

module.exports = {
    getAccount,
    checkAccount,
    checkBalance,
    registerAccount,
};