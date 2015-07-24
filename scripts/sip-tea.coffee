# Description:
#   Kermit sipping tea
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   none of my business - Display a gif of kermit sipping tea
#
# Author:
#   Nick Pabon

threshold = 1
module.exports = (robot) ->
  robot.hear /none ?of ?my ?business/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "sip-tea") || threshold
    if random < roomThreshold
      msg.send 'http://i.imgur.com/oyjb1pd.gif'
