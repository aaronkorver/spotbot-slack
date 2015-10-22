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
#    It's Happening - Displays Ron Paul "It's happening!" gif
#
# Author
#    Hatz & Gang

threshold = 0.0

module.exports = (robot) ->
  robot.hear /it'?s\s?happening/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "itshappening", threshold)
    if random < roomThreshold
      message.send "http://i.imgur.com/7drHiqr.gif"
