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
#    this is fine - displays this is fine dog cartoon
#    probably fine  - displays this is fine dog cartoon
#
# Author
#    Colton Karoses

threshold = 1.0

module.exports = (robot) ->
  robot.hear /this\s?is\s?fine|probably\s?fine/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "thisisfine", threshold)
    if random < roomThreshold
      message.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/2297566/SHSr2lZKgkyVMT2/thisisfinedog.png"
