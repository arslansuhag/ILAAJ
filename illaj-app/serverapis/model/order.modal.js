const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const orderSchema = new Schema({
    mid:{
        type:String,
    },
    uid:{
        type:String,
    },
    status:{
        type:String,
    },
    quantity:{
        type:String,
    },
    paymode:{
        type:String,
    },
});

const orderModel = db.model('order',orderSchema);
module.exports = orderModel;