# Description
#    This is fine
#
# Dependencies
#    None
#
# Confiuration:
#    None
#
# Commands:
#    This is fine - Displays a dog in a burning house.
#
# Author
#    Colton Karoses

threshold = 1.0

module.exports = (robot) ->
  robot.hear /this\s?is\s?fine/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "thisisfine", threshold)
    if random < roomThreshold
      message.send "http://i.imgur.com/c4jt321.png"
