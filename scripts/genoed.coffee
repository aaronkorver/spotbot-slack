# Description:
#   A mad angry little man
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   genoed - when someone gets mad in the Dojo and just wants to be difficult
#
# Author:
#   christopher.schwartz (based off of lunch.coffee script)

threshold = 0.01
genoGifs = [
  "http://i.imgur.com/0Y1xISa.gifv"
  "http://stream1.gifsoup.com/webroot/animatedgifs5/3362933_o.gif"
]

module.exports = (robot) ->
    robot.hear /(^|[\s])\bgenoed\b/i, (msg) ->
        random = Math.random()
        roomThreshold = robot.thresholdStorage.getThreshold(msg, "genoed", threshold)
        if random < roomThreshold
            msg.send msg.random genoGifs
