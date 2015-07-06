# Description:
#   BAN HAMMER
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   banhammer - displays a banhammer image
#
# Author:
#   Jordan McGowan

hammers= [
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2268827/v0p3JPz7QLDzAoy/WOjy315.gif"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2268827/QcvLa1uDWqeMG33/giphy.gif"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2268827/W14J2pUCwKmJ1O2/BanHammer.gif"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2268827/wmsfG1W7Si7Vodp/40c.gif"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2268827/xCyiAB24Qno68si/banhammer-header.jpg"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2268827/zChgvAbMjBE4JxO/ban-hammer-featured1.jpg"
]


module.exports = (robot) ->
  robot.hear /ban ?hammer/i, (msg) ->
    msg.send msg.random hammers
