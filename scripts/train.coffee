# Description:
#   Hubot responds to any mention of the word train
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   Anyone ready for the lunch train?
#   Choo! Choo!
#

threshold = 0.25

module.exports = (robot) ->
  robot.hear /\btrain\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "train", threshold)
    if random < roomThreshold
        msg.send "Choo! Choo!"
