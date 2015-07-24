# Description:
#   Hubot responds to any mention of the word vendor
#
# Dependencies:
#   None
#
# Configuration:
#   None
# Author:
#   Rod
#

threshold = 0.35
module.exports = (robot) ->
  robot.hear /\bvendor\b/i, (msg) ->

    if msg.message.user.mention_name?
      sender =  msg.message.user.mention_name.toLowerCase()
    else
      sender = msg.message.user.name
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "vendor") || threshold
    if random < roomThreshold
      msg.send "@#{sender}, I think you meant 'Strategic Partners'"
