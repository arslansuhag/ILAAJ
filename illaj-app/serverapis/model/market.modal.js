const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const marketSchema = new Schema({
    title:{
        type:String,
    },
    des:{
        type:String,
    },
    img:{
        type:String,
    },
    type:{
        type:String,
    },
    wishlist:[],
    price:{
        type:String,
    }
});

const marketModel = db.model('market',marketSchema);
module.exports = marketModel;