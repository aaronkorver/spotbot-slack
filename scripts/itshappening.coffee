# Description
#    Ron Paul Revolution
#
# Dependencies
#    None
#
# Confiuration:
#    None
#
# Commands:
#    It's Happening - Ron Paul Revolution
#
# Author
#    Hatz & Gang

threshold = 0.5

module.exports = (robot) ->
  robot.hear /it'?s\s?happening/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "itshappening") || threshold
    if random < roomThreshold
      message.send "http://i.imgur.com/7drHiqr.gif"
