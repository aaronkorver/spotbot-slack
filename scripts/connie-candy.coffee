# Description:
#   Hubot shows the evidence of Connie's post-Easter candy
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot how much candy did connie eat?
#

threshold = 1

module.exports = (robot) ->
  robot.respond /how much candy did connie eat/i, (msg) ->
    random = Math.random()
    roomThreshold = robot.thresholdStorage.getThreshold(msg, "connie-candy", threshold)
    if random < roomThreshold
        msg.send "The evidence is in:"
        msg.send "https://s3.amazonaws.com/uploads.hipchat.com/171096/1531270/yMmCJcyS6v9fKOp/upload.jpg"
