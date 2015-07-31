# Description:
#   Bees are insane
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   bees - Oprah at her finest, or a good way to turn the fans on coworkers machines
#
# Author:
#   atmos

threshold = 0.75

module.exports = (robot) ->
  robot.hear /\bbee+s?\b/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "bees", threshold)
    if random < roomThreshold
      message.send "http://i.imgur.com/qrLEV.gif"
