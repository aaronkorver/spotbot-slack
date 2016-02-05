

# Description:
#   Databags are funny
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   databags - Commander data with a handbag
#
# Author:
#   joe.talbot

threshold = 0.1

module.exports = (robot) ->
  robot.hear /\bdatabag+s?\b/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "databag?", threshold)
    if random < roomThreshold
      message.send "http://i.imgur.com/LegP2Ip.jpg"
