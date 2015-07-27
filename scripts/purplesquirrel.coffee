# Description:
#   Purple Squirrel
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#  ZakBrown


threshold = 0
purpleSquirrels = [
    "http://appirio.com/wp-content/uploads/2013/05/Purple-Squirrel.png"
    "http://pcplacements.com/wp-content/uploads/purple-squirrel.jpg"
    "http://thevesumegroup.com/wp-content/uploads/2014/07/Purple-e1406726964898.jpg"
    "http://exactsource.com/portals/11/Cinco%20De%20Mayo%20Squirrel.jpg"   
]


module.exports = (robot) ->
  robot.hear /(Engineers?\b|Developers?|Purple Squirrels?)/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "purplesquirrel") || threshold
    if random < roomThreshold
      msg.send msg.random purpleSquirrels
