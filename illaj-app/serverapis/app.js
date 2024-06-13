const express = require("express");
const bodyParser = require("body-parser")
const UserRoute = require("./routers/user.route");
const healthRoute = require("./routers/healthArticles.route");
const appointmentRoute = require("./routers/appointments.route");
const marketRoute = require("./routers/market.route");
const orderRoute = require("./routers/order.route");
const chatRoute = require("./routers/chat.route");
const remainderRoute = require("./routers/remainder.route");
const emergenceRoute = require("./routers/emergence.route");

const app = express();
app.use(bodyParser.json());
app.use("/",UserRoute);
app.use("/",healthRoute);
app.use("/",appointmentRoute);
app.use("/",marketRoute);
app.use("/",orderRoute);
app.use("/",chatRoute);
app.use("/",remainderRoute);
app.use("/",emergenceRoute);

module.exports = app;