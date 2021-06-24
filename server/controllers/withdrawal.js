const { request, response } = require('express');
const Withdrawal = require('../models/withdrawal');
const Account = require('../models/account');

const getWithdrawal = (req = request, res = response) => {
    Withdrawal.findOne({ number: req.params.number }, { __v: 0 })
        .populate('account', { __v: 0, withdrawals: 0, balance: 0 })
        .then((result) => {
            res.json({ data: result });
        })
        .catch((error) => {
            res.status(500).json({ msg: error });
        });
};

const checkWithdrawal = (req = request, res = response) => {
    Withdrawal.findOne({ number: req.params.number }, (error, result) => {
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
    });
};

const registerWithdrawal = (req = request, res = response) => {
    console.log('Inside the register');
    const withdrawal = new Withdrawal({
        number: Date.now(),
        amount: req.body.amount,
        account: req.body.account,
    });
    withdrawal.save((error) => {
        if (error) return res.status(403).json({ msg: error });
        console.log('Withdrawal registered');
        const _id = req.body.account;
        Account.findOne({ _id: _id }, (error, result) => {
            if (error) return res.status(403).json({ msg: error });
            const newBalance = parseInt(result.balance) - parseInt(req.body.amount);
            Account.findByIdAndUpdate(
                { _id: _id },
                { balance: newBalance, $push: { withdrawals: withdrawal._id } },
                (error) => {
                    if (error) return res.status(500).json({ msg: error });
                }
            );
        });
        res.status(200).json('Ok');
    });
};

module.exports = {
    getWithdrawal,
    checkWithdrawal,
    registerWithdrawal,
};
