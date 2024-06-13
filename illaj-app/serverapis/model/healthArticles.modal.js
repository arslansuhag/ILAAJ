const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const healthArticlesSchema = new Schema({
    uid:{
        type:String,
    },
    title:{
        type:String,
    },
    description:{
        type:String,
    },
    imageUrl:{
        type:String,
    }
});

const healthArticlesModel = db.model('healthArticles',healthArticlesSchema);
module.exports = healthArticlesModel;