const mongoose = require('mongoose');
const bcrypt = require("bcrypt");
const db = require('../config/db');

const { Schema } = mongoose;

const userSchema = new Schema({
    email:{
        type:String,
        require:true,
        unique:true,
    },
    name:{
        type:String,
    },
    phone:{
        type:String,
        require:true
    },
    password:{
        type:String,
    },
    type:{
        type:String,
    },
    deviceid:{
        type:String,
    },
    experience:{
        type:String,
    },
    specialization:{
        type:String,
    },
    description:{
        type:String,
    },
    location:{
        type:String,
    },
    img:{
        type:String,
    },
    itemrating:{
        type:String,
    },
    itemuser:{
        type:String,
    },
    status:{
        type:String,
    },
});

userSchema.pre("save",async function(){
    try{
        var user = this;
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(user.password,salt);
        user.password = hash;
    } catch(e){
        throw e;
    }
})

userSchema.methods.comparePassword = async function(userpassword){
    try{
        const isMatch = await bcrypt.compare(userpassword,this.password);
        return isMatch;
    } catch(e){
        throw e;
    }
}

const UserModel = db.model('user',userSchema);
module.exports = UserModel;