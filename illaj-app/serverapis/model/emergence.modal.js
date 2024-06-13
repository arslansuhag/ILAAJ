const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const emergenceSchema = new Schema({
    uid:{
        type:String,
    },
    name:{
        type:String,
    },
    number:{
        type:String,
    },
});

const emergenceModel = db.model('emergence',emergenceSchema);
module.exports = emergenceModel;
