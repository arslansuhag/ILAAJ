const appointment = require('../model/appointments.model');
const app = require('express').Router();

app.post('/registerappointment', async (req, res, next) => {
    try {
      const { doctorId, doctorName, time, date, patientID, patientName, status } = req.body;
      const user = new appointment({doctorId, doctorName, time, date, patientID, patientName, status});
      await user.save();
      res.status(200).json({ status:true ,message:"register sucessfully"});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,message:"try again later" });
    }
});

app.post('/getbypatient', async (req, res, next) => {
    try {
        const { patientID } = req.body; 
      const user = await appointment.find({patientID});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/getbydoctor', async (req, res, next) => {
    try {
        const { doctorId } = req.body; 
      const user = await appointment.find({doctorId});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/deleteappointment', async (req, res, next) => {
    try {
        const { id } = req.body;
      const user = await appointment.findByIdAndDelete(id);
      res.status(200).json({ status:true});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false});
    }
});

app.post('/updateappointment', async (req, res, next) => {
  try {
      const { id , status} = req.body;
    await appointment.findByIdAndUpdate(id,{$set:{status:status}});
    res.status(200).json({ status:true});
  } catch (error) {
    console.log(error);
    res.status(500).json({ status:false});
  }
});

module.exports = app;