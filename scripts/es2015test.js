"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
// Description:
//   test es2015 compatability

exports.default = function (robot) {
  robot.hear(/swing/, function (res) {
    res.send("swung");
  });
};

module.exports = exports['default'];