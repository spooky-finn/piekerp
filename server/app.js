const { execSync } = require("child_process");
const { networkInterfaces } = require('os');

const dotenv = require('dotenv');
dotenv.config({ path: `../.env` });


console.log("🛫 Express running in", process.env.NODE_ENV, 'mode.')

if (process.env.NODE_ENV == 'development') {
  const local_IPv4 = execSync("ifconfig | grep  'inet '").toString();
  console.log(`Your local network settings: \n ${local_IPv4}`)
  // console.dir(');
}

var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require("cors");

const errorMiddleware = require('./middlewares/error-middleware');

//prod
const CLIENT_BUILD_PATH = '/app/client/build';

var indexRouter = require('./routes/index');
const e = require('express');


var app = express();

// Static files
app.use(express.static(CLIENT_BUILD_PATH));

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');


app.use(logger('dev'));

app.use(express.urlencoded({ extended: false }));

app.use(express.static(path.join(__dirname, 'public')));

//Middlewares
app.use(express.json());

app.use(cookieParser());

app.use(cors({
  credentials: true,
  origin: process.env.CORS_CLIENT_URL
}));


app.use('/api', indexRouter);
app.use(errorMiddleware);



// All remaining requests return the React app, so it can handle routing.
app.get('*', function (request, response) {
  response.sendFile(path.join(CLIENT_BUILD_PATH, 'index.html'));
});


module.exports = app;
