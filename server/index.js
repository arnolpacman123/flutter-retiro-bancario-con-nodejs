const express = require('express');
const mongoose = require('mongoose');
const port = process.env.PORT || 5000;
const app = express();
const routes = require('./routes');

mongoose.connect(
    'mongodb+srv://arnolguevara:aspirine@cluster0.vlohb.mongodb.net/retiroDB?retryWrites=true&w=majority',
    {
        useCreateIndex: true,
        useUnifiedTopology: true,
        useNewUrlParser: true,
        useFindAndModify: false,
    }
);

const connection = mongoose.connection;
connection.once('open', () => {
   console.log('MongoDB connected'); 
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/api/v1', routes);

app.listen(port, () => console.log(`Welcome your listinning at port ${ port }`));
