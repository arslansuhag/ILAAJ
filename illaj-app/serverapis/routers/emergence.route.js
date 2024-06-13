const emergence = require('../model/emergence.modal');
const app = require('express').Router();

app.post('/registeremergence', async (req, res, next) => {
    try {
      const {uid, name, number} = req.body;
      const user = new emergence({uid, name, number});
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});

app.post('/allemergencebypat', async (req, res, next) => {
    try {
        const {uid} = req.body;
      const user = await emergence.find({uid});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/cancleemergence', async (req, res, next) => {
    try {
      const {id} = req.body;
      await emergence.findByIdAndDelete(id);
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false });
    }
});


app.post('/updateemergence', async (req, res, next) => {
    try {
      const {id, name, number} = req.body;
      await emergence.findByIdAndUpdate(id,{$set:{name:name, number:number}});
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false });
    }
});

module.exports = app;