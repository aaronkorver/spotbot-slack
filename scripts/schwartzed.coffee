# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   schwartzed - when something goes wrong in the Dojo
#
# Author:
#   lauren.freier (based off of lunch.coffee script)

threshold = 0.01
schwartz = "https://s3.amazonaws.com/uploads.hipchat.com/171096/1460393/eJS8imaxyAH17Zf/schwartzed.gif"

module.exports = (robot) ->
    robot.hear /(^|[\s])\bschwartzed\b/i, (msg) ->
        random = Math.random()
        roomThreshold = robot.thresholdStorage.getThreshold(msg, "schwartzed", threshold)
        if random < roomThreshold
            msg.send schwartz
