const remainder = require('../model/remainder.modal');
const app = require('express').Router();

app.post('/registerremainder', async (req, res, next) => {
    try {
      const { uid, name, date, time } = req.body;
      const user = new remainder({uid, name, date, time});
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});

app.post('/allremainderbyid', async (req, res, next) => {
    try {
        const { uid } = req.body;
      const user = await remainder.find({uid});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

module.exports = app;