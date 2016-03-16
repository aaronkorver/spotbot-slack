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
#    None
#
# Author
#    Colton Karoses

threshold = 1.0

module.exports = (robot) ->
  robot.hear /this\s?is\s?fine||probably\s?fine/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "thisisfine", threshold)
    if random < roomThreshold
      message.send "http://i.imgur.com/c4jt321.png"
