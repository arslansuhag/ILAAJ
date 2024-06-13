const healthArticles = require('../model/healthArticles.modal');
const app = require('express').Router();

app.post('/registerhealthArticles', async (req, res, next) => {
    try {
      const { uid, title, description, imageUrl } = req.body;
      const user = new healthArticles({uid, title, description, imageUrl});
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});

app.post('/allhealthArticles', async (req, res, next) => {
    try {
      const { uid } = req.body;
      const user = await healthArticles.find({uid});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/allhealthArticlestouser', async (req, res, next) => {
  try {
    const user = await healthArticles.find();
    res.status(200).json({ status:true ,data:user});
  } catch (error) {
    console.log(error);
    res.status(500).json({ status:false,data:[] });
  }
});

app.post('/updatehealthArticles', async (req, res, next) => {
    try {
        const { title, description, imageUrl, id } = req.body;
      const user = await healthArticles.findByIdAndUpdate(id,{$set:{title:title, description:description, imageUrl:imageUrl}});
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false});
    }
});

app.post('/deletehealthArticles', async (req, res, next) => {
    try {
        const { id } = req.body;
      const user = await healthArticles.findByIdAndDelete(id);
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false});
    }
});

module.exports = app;