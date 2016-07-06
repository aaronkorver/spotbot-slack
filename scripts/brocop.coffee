# Description:
#   BRO COP
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   bro cop - displays a random bro cop gif
#
# Author:
#   Kurt Poquette

threshold = 1
cops= [
 "http://i.imgur.com/pRpzDzJ.gif",
 "http://i.imgur.com/qmHZB3x.mp4",
 "http://i.imgur.com/8JAhG9c.gif",
 "http://i.imgur.com/q4CdfgF.gif",
 "http://i.imgur.com/5PMCEmF.gif",
 "http://i.imgur.com/qzK9ZJh.gif",
 "http://i.imgur.com/SxRyK5k.gif",
 "http://i.imgur.com/7fERRm0.gif",
 "http://i.imgur.com/asQXBqb.gif",
 "http://i.imgur.com/myqY1uR.gif",
 "http://i.imgur.com/FZ4sEv0.gif"
]


module.exports = (robot) ->
  robot.hear /bro ?cop/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "cop", threshold)
    if random < roomThreshold
      msg.send msg.random cops
