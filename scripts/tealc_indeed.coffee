# Description:
#   Provides some solid Stargate SG-1 Nostalga 
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
#   bschulz

threshold = .25 # defaulting to only 25% because it might get annoying with only these gifs 
indeeds = [
  'http://i.imgur.com/CRIcP.gif',
  'http://i.imgur.com/UDy2dlb.gif',
  'http://i.imgur.com/My93nNQ.gif'
]

module.exports = (robot) ->
  robot.hear /indeed\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "indeed", threshold)
    if random < roomThreshold
      msg.send msg.random indeeds
