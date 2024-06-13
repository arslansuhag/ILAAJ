const order = require('../model/order.modal');
const app = require('express').Router();

app.post('/registerorder', async (req, res, next) => {
    try {
      const { mid, uid, status,quantity,paymode} = req.body;
      const user = new order({mid, uid, status,quantity,paymode});
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});


app.post('/allorder', async (req, res, next) => {
    try {
      const user = await order.find().sort({ _id: -1 });
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});



app.post('/allorderbypat', async (req, res, next) => {
    try {
        const {uid} = req.body;
      const user = await order.find({uid});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/cancleorder', async (req, res, next) => {
    try {
      const {id} = req.body;
      await order.findByIdAndDelete(id);
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false });
    }
});


app.post('/updatestatus', async (req, res, next) => {
    try {
      const {id} = req.body;
      await order.findByIdAndUpdate(id,{$set:{status:"old"}});
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false });
    }
});

module.exports = app;