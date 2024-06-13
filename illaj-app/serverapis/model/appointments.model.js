const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const appointmentSchema = new Schema({
    doctorId:{
        type:String,
    },
    doctorName:{
        type:String,
    },
    time:{
        type:String,
    },
    date:{
        type:String,
    },
    patientID:{
        type:String,
    },
    patientName:{
        type:String,
    },
    status:{
        type:String,
    },
});

const appointmentModel = db.model('appointment',appointmentSchema);
module.exports = appointmentModel;