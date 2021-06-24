const { Schema, model } = require('mongoose');

const userSchema = new Schema({
    name: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    accounts: [
        {
            type: Schema.Types.ObjectId,
            ref: 'Account',
        }
    ],
});

module.exports = model('User', userSchema);