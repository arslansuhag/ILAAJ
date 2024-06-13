const market = require('../model/market.modal');
const app = require('express').Router();

app.post('/registermarket', async (req, res, next) => {
    try {
      const { title, des, img, type, wishlist, price } = req.body;
      const user = new market({title, des, img, type, wishlist, price});
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});

app.post('/updatemarket', async (req, res, next) => {
  try {
    const { id,title, des, img, type, price } = req.body;
    await market.findByIdAndUpdate(id,{$set:{title:title, des:des, img:img, type:type, price:price}});
    res.status(200).json({ status:true});
  } catch (error) {
    console.log(error);
    res.status(500).json({ status:false});
  }
});

app.post('/allmarket', async (req, res, next) => {
    try {
      const user = await market.find();
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/marketone', async (req, res, next) => {
    try {
      const { id } = req.body;
      const user = await market.findById(id);
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/deletemarket', async (req, res, next) => {
  try {
    const { id } = req.body;
    await market.findByIdAndDelete(id);
    res.status(200).json({ status:true});
  } catch (error) {
    console.log(error);
    res.status(500).json({ status:false });
  }
});

app.post('/addwishlist', async (req, res, next) => {
    try {
    const { id, uid } = req.body;
      const user = await market.findById(id);
      user.wishlist.push(uid);
      await market.findByIdAndUpdate(id,{$set:{wishlist:user.wishlist}});
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false });
    }
});

app.post('/removewishlist', async (req, res, next) => {
    try {
    const { id, uid } = req.body;
      const user = await market.findById(id);
      let filteredList = user.wishlist.filter(item => item !== uid);
      await market.findByIdAndUpdate(id,{$set:{wishlist:filteredList}});
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false });
    }
});

module.exports = app;