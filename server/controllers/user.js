const { request, response } = require('express');
const User = require('../models/user');
const Account = require('../models/account');

const getUser = (req = request, res = response) => {
    User.findOne({ email: req.params.email }, { __v: 0 })
        .populate('accounts', { __v: 0 })
        .then((result) => {
            res.json({ data: result });
        })
        .catch((error) => {
            res.status(500).json({ msg: error });
        });
};

const getUserById = (req = request, res = response) => {
    User.findById({ _id: req.params.id }, { __v: 0 })
        .populate('accounts', { __v: 0 })
        .then((result) => {
            res.json({ data: result });
        })
        .catch((error) => {
            res.status(500).json({ msg: error });
        });
};

const checkUser = (req = request, res = response) => {
    User.findOne({ email: req.params.email }, (error, result) => {
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

const registerUser = (req = request, res = response) => {
    console.log('Inside the register');
    const user = new User({
        name: req.body.name,
        email: req.body.email,
    });
    user.save((error) => {
        if (error) return res.status(403).json({ msg: error });
        console.log('User registerd');
        res.status(200).json('Ok');
    });
};

module.exports = {
    getUser,
    checkUser,
    registerUser,
    getUserById
};
