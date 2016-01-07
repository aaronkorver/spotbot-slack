# Description:
#   Le toucan has arrived!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   le toucan
#
# Author:
#   Nick.Jacques

threshold = 0.75

module.exports = (robot) ->
  robot.hear /le toucan\b/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "letoucan", threshold)
    if random < roomThreshold
      message.send "http://i.imgur.com/9tyIQ5D.png"
