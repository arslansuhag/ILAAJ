const usermodel = require('../model/user.modal');
const bcrypt = require("bcrypt");
const app = require('express').Router();

app.post('/signup', async (req, res, next) => {
    try {
      const { email, name, phone, password, type, deviceid, experience, specialization, description,location,img,itemrating,itemuser,status } = req.body;
      const user = new usermodel({ email, name, phone, password, type, deviceid, experience, specialization, description,location,img,itemrating,itemuser,status  });
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});

app.post('/login', async(req,res,next)=>{
    try{
        const {email,password,deviceid} = req.body;
        const user = await usermodel.findOne({email});
        if(!user){
            res.status(200).json({status:false,message:"no user found"});
        } else{
            const isMatch = await user.comparePassword(password);
            if(isMatch == false){
                res.status(200).json({status:false,message:"invalid password"});
            } else{
                await usermodel.findByIdAndUpdate(user._id, { $set: { deviceid: deviceid } });
                res.status(200).json({status:true,data:user,message:"login in sucessfully"});
            }
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
});

app.post('/getoneuser', async(req,res,next)=>{
    try{
        const {id} = req.body;
        const user = await usermodel.findById(id);
        res.status(200).json({status:true,data:user});
    } catch (e){
        console.log(e)
        res.json({status:false,data:{}});
    }
});

app.post('/getdoctor', async(req,res,next)=>{
    try{
        const user = await usermodel.find({type:"doctor"});
        res.status(200).json({status:true,data:user});
    } catch (e){
        console.log(e)
        res.json({status:false,data:{}});
    }
});

app.post('/updateuser', async(req,res,next)=>{
    try{
        const {id,img,name,phone,location} = req.body;
        await usermodel.findByIdAndUpdate(id,{$set:{img:img,name:name,phone:phone,location,location}});
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false,data:{}});
    }
});

app.post('/updateuserd', async(req,res,next)=>{
    try{
        const {id,img,name,phone,location,experience, specialization} = req.body;
        await usermodel.findByIdAndUpdate(id,{$set:{img:img,name:name,phone:phone,location:location,
            experience:experience, specialization:specialization}});
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false,data:{}});
    }
});

app.post('/updatedoctorrating', async(req,res,next)=>{
    try{
        const {id,itemrating} = req.body;
        const u = await usermodel.findById(id);
        u.itemuser = (parseInt(u.itemuser) + 1).toString();
        await usermodel.findByIdAndUpdate(id,{ $set: {itemuser:u.itemuser}});
        u.itemrating = (parseInt(u.itemrating) + parseInt(itemrating)).toString();
        await usermodel.findByIdAndUpdate(id,{ $set: {itemrating:u.itemrating}});
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
});

app.post('/forgetpassword', async(req,res,next)=>{
    try{
        const {email, password} = req.body;
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(password, salt);
        await usermodel.findOneAndUpdate({email: email}, {$set: {password: hash}});
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
});

app.post('/alluser', async (req, res, next) => {
    try {
      const user = await usermodel.find();
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/deleteuser', async (req, res, next) => {
    try {
      const { id } = req.body;
      await usermodel.findByIdAndDelete(id);
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false });
    }
  });

  app.post('/updatedoctorstatus', async(req,res,next)=>{
    try{
        const {id,status} = req.body;
        const u = await usermodel.findByIdAndUpdate(id,{$set:{status:status}});
        res.status(200).json({status:true});
    } catch (e){
        console.log(e)
        res.json({status:false});
    }
});

module.exports = app;