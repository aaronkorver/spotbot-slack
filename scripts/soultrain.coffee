# Description:
#   soultrain
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   none
#
# Author:
#  ChrisMartin

threshold = 0

soulTrains = [
    "http://giphy.com/gifs/train-soul-10KDoqHq5myKQ"
    "http://www.out.com/sites/out.com/files/imce/soul-train-4.gif"
    "http://i.imgur.com/PNEuMOB.gif"
]

module.exports = (robot) ->
  robot.hear /\b(hired|accept(s|ed)?)\b/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "soultrain", threshold)
    if random < roomThreshold
      msg.send msg.random soulTrains
