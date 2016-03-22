# Description:
#   The horses must be unleashed.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   dak

threshold = .75

module.exports = (robot) ->
  robot.hear /unleash the horses\b/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "unleash-the-horses", threshold)
    if random < roomThreshold
      message.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1551645/6km44Pnul12Ajgj/unleash-horses.gif"
