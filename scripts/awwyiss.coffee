# Description:
#   Needs no description.
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
#   arudge

threshold = 0.75

module.exports = (robot) ->
  robot.hear /aw+\s?yis+\b/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "awwyiss", threshold)
    if random < roomThreshold
      message.send "http://i.imgur.com/2roh9QL.gif"
