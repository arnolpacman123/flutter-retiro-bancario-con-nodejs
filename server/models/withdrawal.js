const { Schema, model } = require('mongoose');

const withdrawalSchema = new Schema({
    number: {
        type: Number,
        required: true,
        unique: true,
    },
    date: {
        type: Date,
        default: Date.now
    },
    amount: {
        type: Number,
        required: true,
    },
    account: {
        type: Schema.Types.ObjectId,
        ref: 'Account'
    }
});

module.exports = model('Withdrawal', withdrawalSchema);