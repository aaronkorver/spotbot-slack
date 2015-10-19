# Description:
#   Poking is fun
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   poke - Shaq doesn't like being poked. Maybe someone else will.
#
# Author:
#   pete

threshold = 0.75

module.exports = (robot) ->
  robot.hear /\bpoke?\b/i, (message) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(message, "poke", threshold)
    if random < roomThreshold
      message.send "http://awesomegifs.com/wp-content/uploads/hey-man-stop-poking-the-shaq.gif"
