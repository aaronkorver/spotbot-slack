# Description:
#   Listens for hubot shame and responds with a random GIF of the "Shame Nun" from Game of Thrones

# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot shame - displays the GoT shame nun
#
# Author:
#   GradyJohnson


shame = [
  "http://i.imgur.com/LbrPKu1.gifv"
  "https://s3.amazonaws.com/uploads.hipchat.com/171096/2336240/dW68Ar8UARscXA8/upload.png"
]

module.exports = (robot) ->
  robot.respond /shame\b/i, (message) ->
    message.send message.random shame
