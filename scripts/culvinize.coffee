# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   culvinize - Displays a random culvinization
#
# Author:
#   dakota.reesebrown

culviners = [
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/L5zBxiz3tKE4PyV/rogue.png",
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/8Yl2yFy041FwdvO/culvinized-1.png",
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/57BrwqVEIcKKzjO/culvinized-2.png",
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/uQ6BoxbT0FoAA6G/culvinized-3.png",
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/1xFiNMeFePDUwDN/culvinized-4.png",
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/3PtwiZBXmiCIDUV/culvinized-5.jpg",
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/zvccc8ihS772Q2Q/culvinized-6.jpg",
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/8R0U2wlwWXdZK1D/culvinized-7.png"
]

module.exports = (robot) ->
  robot.hear /culvinize/i, (msg) ->
    msg.send msg.random culviners
