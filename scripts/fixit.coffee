# Description:
#   Fix it, Fix it fix it fix it fix it.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   fix it
#
# Author:
#   Just fix it

threshold = .9

module.exports = (robot) ->
  robot.hear /fix ?it\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "fixit", threshold)
    if random < roomThreshold
      msg.send "http://media20.giphy.com/media/KqWzEMydtRHX2/giphy.gif?w=250"
