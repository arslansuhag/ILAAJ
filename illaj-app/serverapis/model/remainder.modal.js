const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const remainderSchema = new Schema({
    uid:{
        type:String,
    },
    name:{
        type:String,
    },
    date:{
        type:String,
    },
    time:{
        type:String,
    },
});

const remainderModel = db.model('remainder',remainderSchema);
module.exports = remainderModel;