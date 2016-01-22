// Description:
//   test es2015 compatability

export default (robot) => {
  robot.hear(/swing/, (res) => {
    res.send("swung");
  });
}
