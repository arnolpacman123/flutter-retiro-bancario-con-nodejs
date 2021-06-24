const { Schema, model } = require('mongoose');

const accountSchema = new Schema({
    number: {
        type: Number,
        required: true,
        unique: true,
    },
    type: {
        type: String,
        required: true,
    },
    balance: {
        type: Number,
        required: true,
        min: 0,
    },
    user: {
        type: Schema.Types.ObjectId,
        ref: 'User',
    },
    withdrawals: [
        {
            type: Schema.Types.ObjectId,
            ref: 'Withdrawal'
        },
    ],
});

module.exports = model('Account', accountSchema);